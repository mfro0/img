with Ada.Text_IO;
with Ada.Unchecked_Deallocation;

with Ada.Direct_IO;

with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Ada.Command_Line;

with Ada.Directories; use Ada.Directories;
with System;

with Png_IO;

procedure Img is
   type Ubyte is mod 2 ** 8;
   type Ubyte_Array is array(natural range <>) of Ubyte;
   pragma Pack(Ubyte_Array);

   type Uint16 is mod 2 ** 16;
   type Uint16_Array is array(natural range <>) of Uint16;
   pragma Pack(Uint16_Array);
   type Uint16_Array_Ptr is access Uint16_Array;
   
   type Int16 is range -2 ** 15 + 1 .. 2 ** 15 - 1;

   type Img_Header is record
      Version : Uint16;
      Header_Length : Uint16;
      Num_Planes : Uint16;
      Pattern_Length : Uint16;
      Pixel_Width : Uint16;
      Pixel_Height : Uint16;
      Line_Width : Uint16;
      Num_Lines : Uint16;
   end record;
   -- make sure it's word size packed
   pragma Pack(Img_Header);
   -- make sure it's big endian on all platforms
   for Img_Header'Bit_Order use System.High_Order_First;
   for Img_Header'Scalar_Storage_Order use System.High_Order_First;

   function Get_Bin_Content_From_Path(Path : in String) return Ubyte_Array is
      
      subtype My_Ubyte_Array is Ubyte_Array(1 .. Integer(Size(Path)));
      Contents : My_Ubyte_Array;

      package Bin_IO is new Ada.Direct_IO(My_Ubyte_Array);
      use Bin_IO;
      F : Bin_IO.File_Type;

   begin
      Open(F, In_File, Path);
      Read(F, Contents);
      Close(F);

      return(Contents);
   end Get_Bin_Content_From_Path;

   procedure Decompress(Header : Img_Header; Pattern_Length : Integer; Ubytes : Ubyte_Array;
                        Image : in out Uint16_Array_Ptr) is
      index    : Integer := 0;
      finish   : Boolean := False;
      n        : Integer;
      Header_Length renames Integer(Header.Header_Length);
      Num_Planes renames Integer(Header.Num_Planes);
   begin
      index := Header_Length * 2;
      while not finish loop
         case Ubytes(index) is
            when 0 =>
               if Ubytes(index + 1) > 0 then
                  -- pattern run, read (and copy) Header.Pattern_Length Bytes 
                  -- and repeat this n (i.e. Ubytes(index + 1) times 
                  n := Integer(Ubytes(index + 1));
                  for i in 1 .. n loop
                     null;
                  end loop;
                  index := @ + 1 + Pattern_Length;
               elsif Ubytes(index + 1) = 0 then
                  if Ubytes(index + 2) = 16#FF# then
                     -- scanline run. Data for next scan line is to be used
                     -- multiple times
                     -- first byte is 16#FF#, second byte the number of scanlines
                     -- to repeat it, following data is compressed as normal
                     index := @ + 3 + Integer(Ubytes(index + 3));
                  else
                     index := @ + 1;
                     -- FIXME: error
                  end if;
               end if;
            when 16#80#  =>
               -- uncompressed bit string, length is in next byte
               index := @ + 1;
               for i in 1 .. Ubytes(index + 1) loop
                  null;
               end loop;
               index := @ + 1;
            when others =>
               -- solid run; high bit determines if 0 or 1, bits 7 to 0 are the 
               -- length of the run in bytes
               index := @ + 1;
         end case;
         Ada.Text_IO.Put_Line(Integer'Image(index));
         if index = Ubytes'Length then
            finish := True;
         end if;
      end loop;
   end Decompress;

   procedure Print_Header(Header : Img_Header) is
      package Integer_Text_IO is new Ada.Text_IO.Integer_IO (Int16);
      package Modular_IO is new Ada.Text_IO.Modular_IO (Num => Uint16);

      use ASCII;
   begin
      Ada.Text_IO.Put_Line("IMG Header");
      Ada.Text_IO.Put_Line("==========");
      Ada.Text_IO.Put("Version" & HT & HT); Modular_IO.Put(Header.Version, 4, 16); Ada.Text_IO.Put_Line("");
      Ada.Text_IO.Put("Header_Length" & HT); Modular_IO.Put(Header.Header_Length, 4, 10); Ada.Text_IO.Put_Line("");
      Ada.Text_IO.Put("Num_Planes" & HT); Modular_IO.Put(Header.Num_Planes, 4, 10); Ada.Text_IO.Put_Line("");
      Ada.Text_IO.Put("Pattern_Length" & HT); Modular_IO.Put(Header.Pattern_Length, 4, 10); Ada.Text_IO.Put_Line("");
      Ada.Text_IO.Put("Pixel_Width" & HT); Modular_IO.Put(Header.Pixel_Width, 4, 10); Ada.Text_IO.Put_Line("");
      Ada.Text_IO.Put("Pixel_Height" & HT); Modular_IO.Put(Header.Pixel_Height, 4, 10); Ada.Text_IO.Put_Line("");
      Ada.Text_IO.Put("Line_Width" & HT); Modular_IO.Put(Header.Line_Width, 4, 10); Ada.Text_IO.Put_Line("");
      Ada.Text_IO.Put("Num_Lines" & HT); Modular_IO.Put(Header.Num_Lines, 4, 10); Ada.Text_IO.Put_Line("");

      Ada.Text_IO.Put("Header'Size" & HT); Integer_Text_IO.Put(Header'Size / Ubyte'Size, 4, 10); Ada.Text_IO.Put_Line("");
   end Print_Header;

begin -- Img
   if Ada.Command_Line.Argument_Count < 1 then
      Ada.Text_IO.Put_Line("usage: " & Ada.Command_Line.Command_Name & "<file.img>");
      Ada.Command_Line.Set_Exit_Status(1);

      return;
   end if;

   declare
      File_Name : String := Ada.Command_Line.Argument(1);

      Ubytes : Ubyte_Array(1 .. Integer(Size(File_Name)));
      for Ubytes'Alignment use 2;
      Header : aliased Img_Header;
      for Header'Address use Ubytes'Address;

      Image : Uint16_Array_Ptr;
      procedure Deallocate_Image is new Ada.Unchecked_Deallocation(Uint16_Array, Uint16_Array_Ptr);
   begin
      Ubytes := Get_Bin_Content_From_Path(File_Name);
      Image := new Uint16_Array(1 .. Integer(Header.Line_Width) *
                                     Integer(Header.Num_Lines) *
                                     Integer(Header.Num_Planes) / Uint16'Size);

      Ada.Text_IO.Put_Line("Image array takes " & Integer'Image(Integer(Header.Line_Width) *
                                                                Integer(Header.Num_Lines) *
                                                                Integer(Header.Num_Planes) /
                                                                Uint16'Size) & " words (" &
                                                                Integer'Image(Image.all'Size / Ubyte'Size) &
                                                                " Bytes)");

      Print_Header(Header);

      Decompress(Header, Integer(Header.Pattern_Length), Ubytes, Image);

      Deallocate_Image(Image);
   end;
   Ada.Command_Line.Set_Exit_Status(0);
end Img;
