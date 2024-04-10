with System;
with System.Machine_Code; use System.Machine_Code;
with Interfaces; use Interfaces;
with Interfaces.C.Strings;
with Ada.Unchecked_Conversion;
with Ada.Text_IO; use Ada.Text_IO;

package body GEM.AES.Graf is
   use ASCII;
   function To_Address is new Ada.Unchecked_Conversion(System.Address, Unsigned_32);
   
   function Handle(Char_Width, Char_Height, Char_Box_Width, Char_Box_Height : out Int16) return Int16 is
   begin
      Cntrl := (0 => 77, 2 => 5, others => 0);
      Asm("move.l       %0,%%d1"          & LF & HT &
          "move.w       #200,%%d0"        & LF & HT &
          "trap         #2"             & LF & HT,
          Volatile => True,
          Inputs => Interfaces.Unsigned_32'Asm_Input("g", To_Address(Aes_Pb'Address)), 
          Clobber => "d0,d1,a0,a1"
      );
      Char_Width := Int16(Int_Out(1));
      Char_Height := Int16(Int_Out(2));
      Char_Box_Width := Int16(Int_Out(3));
      Char_Box_Height := Int16(Int_Out(4));

      return Int16(Int_Out(0));
   end Handle;

   procedure Mouse(Form : Mouse_Type) is
   begin
      Cntrl := (0 => 78, 1 => 1, 2 => 1, 3 => 1, others => 0);
      Int_In(0) := Mouse_Type'Enum_Rep(Form);
      -- Addr_In(0) := To_Address(0);
      Asm("move.l       %0,%%d1"          & LF & HT &
          "move.w       #200,%%d0"        & LF & HT &
          "trap         #2"             & LF & HT,
          Volatile => True,
          Inputs => Interfaces.Unsigned_32'Asm_Input("g", To_Address(Aes_Pb'Address)), 
          Clobber => "d0,d1,a0,a1"
      );
   end Mouse;

   type Bitmap_Pointer is new System.Address;
   procedure Mouse(Form : Mouse_Type; Bits : Bitmap_Pointer) is

   begin
      Cntrl := (0 => 78, 1 => 1, 2 => 1, 3 => 1, others => 0);
      Int_In(0) := Mouse_Type'Enum_Rep(Form);
      -- Addr_In(0) := To_Address(Bits);
      Asm("move.l       %0,%%d1"          & LF & HT &
          "move.w       #200,%%d0"        & LF & HT &
          "trap         #2"             & LF & HT,
          Volatile => True,
          Inputs => Interfaces.Unsigned_32'Asm_Input("g", To_Address(Aes_Pb'Address)), 
          Clobber => "d0,d1,a0,a1"
      );
   end Mouse;

   procedure Grow_Box(X0, Y0, W0, H0, X1, Y1, W1, H1 : Int16) is
   begin
       Cntrl := (0 => 73, 1 => 8, 2 => 1, others => 0);
       Int_In := (0 => 73, 1 => Uint16(X0), 2 => Uint16(Y0), 3 => Uint16(W0), 4 => Uint16(H0),
                           5 => Uint16(X1), 6 => Uint16(Y1), 7 => Uint16(W1), 8 => Uint16(H1),
                           others => 0);
       Asm("move.l       %0,%%d1"          & LF & HT &
           "move.w       #200,%%d0"        & LF & HT &
           "trap         #2"             & LF & HT,
           Volatile => True,
           Inputs => Interfaces.Unsigned_32'Asm_Input("g", To_Address(Aes_Pb'Address)),
           Clobber => "d0,d1,a0,a1"
       );
   end Grow_Box;

   procedure Grow_Box(Start_Rect, End_Rect : GEM.AES.Rectangle) is
   begin
      Grow_Box(Start_Rect.X, Start_Rect.Y, Start_Rect.W, Start_Rect.H,
               End_Rect.X, End_Rect.Y, End_Rect.W, End_Rect.H);
   end Grow_Box;
end GEM.AES.Graf;
