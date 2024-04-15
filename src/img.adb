with Ada.Text_IO;

with Ada.Direct_IO;

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Command_Line;

with Ada.Directories; use Ada.Directories;
with System;


procedure Img is
   type Byte is range -128 .. 127;
   type Byte_Array is array(natural range <>) of Byte;

   type Uint16 is range 0 .. 2 ** 16 - 1;
   type Uint16_Array is array(natural range <>) of Uint16;

   function Get_Bin_Content_From_Path(Path : in String) return Byte_Array is
      
      subtype My_Byte_Array is Byte_Array(1 .. Integer(Size(Path)));
      Contents : My_Byte_Array;

      package Bin_IO is new Ada.Direct_IO(My_Byte_Array);
      use Bin_IO;
      F : Bin_IO.File_Type;

   begin
      Open(F, In_File, Path);
      Read(F, Contents);
      Close(F);

      return(Contents);
   end Get_Bin_Content_From_Path;

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
   pragma Pack(Img_Header);
   for Img_Header'Bit_Order use System.High_Order_First;
   for Img_Header'Scalar_Storage_Order use System.High_Order_First;

   File_Name : Ada.Strings.Unbounded.Unbounded_String;
begin -- Img
   if Ada.Command_Line.Argument_Count < 1 then
      Ada.Text_IO.Put_Line("usage: " & Ada.Command_Line.Command_Name & "<file.img>");
      Ada.Command_Line.Set_Exit_Status(1);

      return;
   end if;

   File_Name := Ada.Strings.Unbounded.To_Unbounded_String(Ada.Command_Line.Argument(1));

   declare
      Bytes : Byte_Array(1 .. Integer(Size(To_String(File_Name))));
      for Bytes'Alignment use 2;
      Header : aliased Img_Header;
      for Header'Address use Bytes'Address;
      package Integer_Text_IO is new Ada.Text_IO.Integer_IO (Uint16);
   begin
      Bytes := Get_Bin_Content_From_Path(Ada.Strings.Unbounded.To_String(File_Name));

      for i in Bytes'Range loop
         -- Ada.Text_IO.Put_Line("Bytes(" & Natural'Image(i) & ") = " & Byte'Image(Bytes(i)));
         null;
      end loop;
      Ada.Text_IO.Put("Version = "); Integer_Text_IO.Put(Header.Version, 4, 16); Ada.Text_IO.Put_Line("");
      Ada.Text_IO.Put("Header_Length = "); Integer_Text_IO.Put(Header.Header_Length, 4, 10); Ada.Text_IO.Put_Line("");
      Ada.Text_IO.Put("Num_Planes = "); Integer_Text_IO.Put(Header.Num_Planes, 4, 10); Ada.Text_IO.Put_Line("");
      Ada.Text_IO.Put("Pattern_Length = "); Integer_Text_IO.Put(Header.Pattern_Length, 4, 10); Ada.Text_IO.Put_Line("");
      Ada.Text_IO.Put("Pixel_Width = "); Integer_Text_IO.Put(Header.Pixel_Width, 4, 10); Ada.Text_IO.Put_Line("");
      Ada.Text_IO.Put("Pixel_Height = "); Integer_Text_IO.Put(Header.Pixel_Height, 4, 10); Ada.Text_IO.Put_Line("");
      Ada.Text_IO.Put("Line_Width = "); Integer_Text_IO.Put(Header.Line_Width, 4, 10); Ada.Text_IO.Put_Line("");
      Ada.Text_IO.Put("Num_Lines = "); Integer_Text_IO.Put(Header.Num_Lines, 4, 10); Ada.Text_IO.Put_Line("");


   end;
   Ada.Command_Line.Set_Exit_Status(0);
end Img;
