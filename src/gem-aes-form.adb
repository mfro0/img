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

      Asm("move.l       %0,%%d1"          & LF & HT &
          "move.w       #200,%%d0"        & LF & HT &
          "trap         #2"             & LF & HT,
          Volatile => True,
          Inputs => Interfaces.Unsigned_32'Asm_Input("g", To_Address(Aes_Pb'Address)), 
          Clobber => "d0,d1"
      );

      return Int16(Int_Out(0));
   end Alert;

   procedure Dial(What : Dialog_Flag; X0, Y0, W0, H0, X1, Y1, W1, H1 : Int16) is
      use ASCII;
      function To_Address is new Ada.Unchecked_Conversion(System.Address, Unsigned_32);
   begin
      Cntrl := (0 => 51, 1 => 9, 2 => 1, others => 0);
      Int_In := (0 => Uint16(Dialog_Flag'Pos(What)),
                 1 => Uint16(X0),
                 2 => Uint16(Y0),
                 3 => Uint16(W0),
                 4 => Uint16(H0),
                 5 => Uint16(X1),
                 6 => Uint16(Y1),
                 7 => Uint16(W1),
                 8 => Uint16(H1),
                 others => 0);
      
      Asm("move.l       %0,%%d1"          & LF & HT &
          "move.w       #200,%%d0"        & LF & HT &
          "trap         #2"             & LF & HT,
          Volatile => True,
          Inputs => Interfaces.Unsigned_32'Asm_Input("g", To_Address(Aes_Pb'Address)), 
          Clobber => "d0,d1"
      );
   end Dial;

   procedure Dial(What : Dialog_Flag; R0, R1 : GEM.AES.Rectangle) is
   begin
      Dial(What, R0.X, R0.Y, R0.W, R0.H, R1.X, R1.Y, R1.W, R1.H);
   end Dial;

   -- function Form_Do(Tree_Ptr : GEM.AES.Object.Tree_P; Start_Index : Int16) return Int16 is
   -- begin
      -- Cntrl := (0 => 50, 1 .. 3 => 1, 4 => 0);
      -- Int_In(0) := Start_Index;
      -- Addr_In(0) := Tree_Ptr;
-- 
      -- Asm("move.l       %0,d1"          & LF & HT &
          -- "move.w       #200,d0"        & LF & HT &
          -- "trap         #2"             & LF & HT,
          -- Volatile => True,
          -- Inputs => Interfaces.Unsigned_32'Asm_Input("g", To_Address(Aes_Pb'Address)), 
          -- Clobber => "d0,d1"
      -- );
      -- return Int16(Int_Out(0));
   -- end Form_Do;
end GEM.AES.Form;
