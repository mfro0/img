with System;
with System.Machine_Code; use System.Machine_Code;
with Interfaces; use Interfaces;
with Interfaces.C.Strings;
with Ada.Unchecked_Conversion;

package body GEM.AES.Form is
   function Alert(Default_Button : Int16; Alert_String : String) return Int16 is
      use ASCII;
      pragma Inline(Alert);
         
      S : String := Alert_String & NUL;
      function To_Address is new Ada.Unchecked_Conversion(System.Address, Unsigned_32);
   
   begin
      Cntrl := (0 => 52, 1 .. 3 => 1, 4 => 0);
      Int_In(0) := Uint16(Default_Button);
      Addr_In(0) := S(1)'Address;

      Asm("move.l       %0,d1"          & LF & HT &
          "move.w       #200,d0"        & LF & HT &
          "trap         #2"             & LF & HT,
          Volatile => True,
          Inputs => Interfaces.Unsigned_32'Asm_Input("g", To_Address(Aes_Pb'Address)), 
          Clobber => "d0,d1"
      );

      return Int16(Int_Out(0));
   end Alert;
end GEM.AES.Form;