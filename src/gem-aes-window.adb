with System;
with System.Machine_Code; use System.Machine_Code;
with Interfaces; use Interfaces;
with Interfaces.C.Strings;
with Ada.Unchecked_Conversion;
with Ada.Text_IO; use Ada.Text_IO;

package body GEM.AES.Window is
    use ASCII;
    function To_Address is new Ada.Unchecked_Conversion(System.Address, Unsigned_32);
   
    function Get_Rectangle(Handle : Int16; What : Action_Type) return Rectangle is
        Rect    : Rectangle;
    begin
        Cntrl := (0 => 104, 1 => 2, 2 => 5, others => 0);
        Int_In(0) := Uint16(Handle);
        Int_In(1) := Action_Type'Enum_Rep(What);
        Asm("move.l       %0,d1"          & LF & HT &
            "move.w       #200,d0"        & LF & HT &
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
    end Get_Rectangle;

end GEM.AES.Window;