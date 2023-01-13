with System;
with System.Machine_Code; use System.Machine_Code;
with Interfaces; use Interfaces;
with Interfaces.C.Strings;
with Ada.Unchecked_Conversion;
with Ada.Text_IO; use Ada.Text_IO;

package body GemAes is
   type uint16_array_type is array(integer range <>) of uint16;
   type uint16_array_access is access all uint16_array_type;

   type address_array_type is array(integer range <>) of System.Address;
   type address_array_access is access all address_array_type;

   type aespb_type is record
      pcontrol,
      pglobal,
      pintin,
      pintout      : System.Address;
      paddrin,
      padrout      : System.Address;
   end record;

   control,
   global,
   intin,
   intout         : aliased uint16_array_type(0 .. 127) := (others => 0);

   addrin,
   addrout         : aliased address_array_type(0 .. 4);

   aespb : aespb_type := aespb_type'(control'Address, global'Address,
                                     intin'Address, intout'Address,
                                     addrin'Address, addrout'Address);

   function Application_Init return int16 is
      use ASCII;
      pragma inline(Application_Init);
      function to_address is new Ada.Unchecked_Conversion(System.Address, Unsigned_32);
   begin
      control := (others => 0);
      control(0) := 10;     -- appl_init()
      control(2) := 1;      -- elements in int_out
      Asm("move.l       %0,d1"          & LF & HT &
          "move.w       #200,d0"        & LF & HT &
          "trap         #2"             & LF & HT,
          Volatile => True,
          Inputs => Interfaces.Unsigned_32'Asm_Input("a", to_address(aespb'Address)));
      return int16(intout(0));
   end Application_Init;

   function Application_Exit return int16 is
      use ASCII;
      pragma inline(Application_Exit);
      function to_address is new Ada.Unchecked_Conversion(System.Address, Unsigned_32);
   begin
      control := (others => 0);
      control(0) := 19;    -- appl_exit();
      control(2) := 1;
      Asm("move.l    %0,d1"            & LF & HT &
          "move.w    #200,d0"          & LF & HT &
          "trap      #2"               & LF & HT,
          Volatile => True, 
          Inputs => Interfaces.Unsigned_32'Asm_Input("g", To_Address(aespb'Address))
      );
      return int16(intout(0));
   end Application_Exit;

   function Form_Alert(default_button : int16; alert_string : string) return int16 is
      use ASCII;
      -- pragma inline(Form_Alert);
         
      s : string := alert_string & NUL;
      function to_address is new Ada.Unchecked_Conversion(System.Address, Unsigned_32);
   
   begin
      control(0) := 52;         -- form_alert()
      control(1) := 1;          -- elements in int_in
      control(2) := 1;          -- elements in int_out
      control(3) := 1;          -- elements in addr_in
      control(4) := 0;          -- elements in addr_out

      intin(0) := uint16(default_button);
      addrin(0) := s(1)'Address;

      Asm("move.l       %0,d1"          & LF & HT &
          "move.w       #200,d0"        & LF & HT &
          "trap         #2"             & LF & HT,
          Volatile => True,
          Inputs => Interfaces.Unsigned_32'Asm_Input("g", to_address(aespb'Address))
      );

      return int16(intout(0));
   end Form_Alert;
end GemAes;
