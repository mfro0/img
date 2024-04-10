with System;
with System.Machine_Code; use System.Machine_Code;
with Interfaces; use Interfaces;
with Interfaces.C.Strings;
with Ada.Unchecked_Conversion;
with Ada.Text_IO; use Ada.Text_IO;

package body GEM.AES.Window is
   use ASCII;
   function To_Address is new Ada.Unchecked_Conversion(System.Address, Unsigned_32);
   
   procedure Calc(What : Calc_Mode; Kind : Window_Components; 
                  Old_X, Old_Y, Old_W, Old_H : Int16;
                  New_X, New_Y, New_W, New_H : out Int16) is
   begin
      Cntrl := (0 => 108, 1 => 6, 2 => 5, others => 0);
      Int_In := (0 => Uint16(Calc_Mode'Pos(What)),
                 1 => Uint16(Kind),
                 2 => Uint16(Old_X), 3 => Uint16(Old_Y),
                 4 => Uint16(Old_W), 5 => Uint16(Old_H), others => 0);
      Asm("move.l       %0,%%d1"        & LF & HT &
          "move.w       #200,%%d0"      & LF & HT &
          "trap         #2"             & LF & HT,
          Volatile => True,
          Inputs => Interfaces.Unsigned_32'Asm_Input("g", To_Address(Aes_Pb'Address)),
          Clobber => "d0,d1,a0,a1"
      );
      New_X := Int16(Int_Out(1));
      New_Y := Int16(Int_Out(2));
      New_W := Int16(Int_Out(3));
      New_H := Int16(Int_Out(4));

      -- TODO: do something with Int_Out(0) (return value). Assert? Exception?
   end Calc;

   procedure Calc(What : Calc_Mode; Kind : Window_Components;
                  Old_Rect : GEM.AES.Rectangle;
                  New_Rect : out GEM.AES.Rectangle) is
   begin
      Calc(What, Kind, Old_Rect.X, Old_Rect.Y, Old_Rect.W, Old_Rect.H, 
                       New_Rect.X, New_Rect.Y, New_Rect.W, New_Rect.H);
   end Calc;

   function Get(Handle : Int16; What : Action_Type) return Rectangle is
      Rect    : Rectangle;
   begin
      Cntrl := (0 => 104, 1 => 2, 2 => 5, others => 0);
      Int_In(0) := Uint16(Handle);
      Int_In(1) := Action_Type'Enum_Rep(What);
      Asm("move.l       %0,%%d1"        & LF & HT &
          "move.w       #200,%%d0"      & LF & HT &
          "trap         #2"             & LF & HT,
          Volatile => True,
          Inputs => Interfaces.Unsigned_32'Asm_Input("g", To_Address(Aes_Pb'Address)),
          Clobber => "d0,d1,a0,a1"
      );
      Rect.X := Int16(Int_Out(1));
      Rect.Y := Int16(Int_Out(2));
      Rect.W := Int16(Int_Out(3));
      Rect.H := Int16(Int_Out(4));

      return Rect;
   end Get;

   procedure Set(Handle : Int16; What : Action_Type; Rect : GEM.AES.Rectangle) is
   begin
      null;
   end Set;

   procedure Set(Handle : Int16; What : Action_Type; X, Y, W, H : Int16) is
   begin
      null;
   end Set;

   procedure Open(Handle : Int16; X, Y, W, H : Int16) is
   begin
      Cntrl := (0 => 101, 1 => 5, 2 => 1, others => 0);
      Int_In(0) := Uint16(Handle);
      Int_In(1) := Uint16(X);
      Int_In(2) := Uint16(Y);
      Int_In(3) := Uint16(W);
      Int_In(4) := Uint16(H);
      Asm("move.l       %0,%%d1"        & LF & HT &
          "move.w       #200,%%d0"      & LF & HT &
          "trap         #2"             & LF & HT,
          Volatile => True,
          Inputs => Interfaces.Unsigned_32'Asm_Input("g", To_Address(Aes_Pb'Address)),
          Clobber => "d0,d1,a0,a1"
      );
   end Open;

   procedure Open(Handle : Int16; Area : GEM.AES.Rectangle) is
   begin
      Open(Handle, Area.X,  Area.Y, Area.W, Area.H);
   end Open;
end GEM.AES.Window;
