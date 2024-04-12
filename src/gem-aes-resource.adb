with System;
with System.Machine_Code; use System.Machine_Code;
with Interfaces; use Interfaces;
with Interfaces.C.Strings;
with Ada.Unchecked_Conversion;

package body GEM.AES.Resource is
   use ASCII;

   function To_Address is new Ada.Unchecked_Conversion(System.Address, Unsigned_32);
   
   procedure Get_Address(Typ : Resource_Type; Index : Int16; Addr : in out Resource_t) is
   begin
      Cntrl := (0 => 112, 1 => 2, 2 => 1, 4 => 1, others => 0);
      Int_In := (0 => Uint16(Resource_Type'Enum_Rep(Typ)), 1 => Uint16(Index), others => 0);
      Asm("move.l       %0,%%d1"       & LF & HT &
          "move.w       #200,%%d0"     & LF & HT &
          "trap         #2"            & LF & HT, 
          Volatile => True,
          Inputs => Interfaces.Unsigned_32'Asm_Input("g", To_Address(Aes_Pb'Address)), 
          Clobber => "d0,d1,a0,a1"
      );
      Addr := Addr_Out(0);

      if Int_Out(0) = 0 then
         raise AES_Exception with "failed to get address (" & System.Address'image(Aes_Pb'Address) & ")";
      end if;
   end Get_Address;

   procedure Free is
   begin
      Cntrl := (0 => 111, 2 => 1, others => 0);
      Asm("move.l       %0,%%d1"       & LF & HT &
          "move.w       #200,%%d0"     & LF & HT &
          "trap         #2"            & LF & HT, 
          Volatile => True,
          Inputs => Interfaces.Unsigned_32'Asm_Input("g", To_Address(Aes_Pb'Address)), 
          Clobber => "d0,d1,a0,a1"
      );

      if Int_Out(0) = 0 then
         raise AES_Exception with "failed to free resource";
      end if;
   end Free;

   procedure Load(Resource_Name : String) is
      S       : String := Resource_Name & NUL;
   begin
      Cntrl := (0 => 110, 2 => 1, 3 => 1, others => 0);
      Addr_In(0) := S(1)'Address;
      Asm("move.l       %0,%%d1"       & LF & HT &
          "move.w       #200,%%d0"     & LF & HT &
          "trap         #2"            & LF & HT, 
          Volatile => True,
          Inputs => Interfaces.Unsigned_32'Asm_Input("g", To_Address(Aes_Pb'Address)), 
          Clobber => "d0,d1,a0,a1"
      );
      
      if Int_Out(0) = 0 then
         raise AES_Exception with "failed to load resource """ & Resource_Name & """";
      end if;
   end Load;
end GEM.AES.Resource;
