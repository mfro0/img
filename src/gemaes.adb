with System;
with System.Machine_Code; use System.Machine_Code;
with Interfaces; use Interfaces;
with Interfaces.C.Strings;
with Ada.Unchecked_Conversion;
with Ada.Text_IO; use Ada.Text_IO;

package body GemAes is
   type uint16_array_type is array(integer range <>) of uint16;
   type address_array_type is array(integer range <>) of System.Address;

   type aespb_type is record
      pcontrol,
      pglobal,
      pintin,
      pintout      : System.Address;
      paddrin,
      padrout      : System.Address;
   end record;

   control        : uint16_array_type(0 .. 4);
   global         : uint16_array_type(0 .. 14);
   intin          : uint16_array_type(0.. 15);
   intout         : uint16_array_type(0 .. 9) := (others => 0);

   addrin         : address_array_type(0 .. 7);
   addrout        : address_array_type(0 .. 1);

   aespb : aespb_type := aespb_type'(control'Address, global'Address,
                                     intin'Address, intout'Address,
                                     addrin'Address, addrout'Address);

   function Application_Init return int16 is
      use ASCII;
      pragma inline(Application_Init);
      function to_address is new Ada.Unchecked_Conversion(System.Address, Unsigned_32);
   begin
      control := (0 => 10, 2 => 1, others => 0);
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
      control := (0 => 19, 2 => 1, others => 0);
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
      pragma inline(Form_Alert);
         
      s : string := alert_string & NUL;
      function to_address is new Ada.Unchecked_Conversion(System.Address, Unsigned_32);
   
   begin
      control := (0 => 52, 1 .. 3 => 1, 4 => 0);
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

   procedure Application_Bitvector_Set(Floppy_Disk_Vector : uint16; Hard_Disk_Vector : uint16) is
      use ASCII;
      pragma inline(Application_Bitvector_Set);
      function to_address is new Ada.Unchecked_Conversion(System.Address, Unsigned_32);
   begin
      control := (0 => 16, 1 => 2, 2 => 1, others => 0);
      Asm("move.l       %0,d1"         & LF & HT &
          "move.w       #200,d0"       & LF & HT &
          "trap         #2"            & LF & HT,
          Volatile => True, 
          Inputs => Interfaces.Unsigned_32'Asm_Input("g", to_address(aespb'Address))
      );
   end Application_Bitvector_Set;

   function Application_Control(Application_ID : in int16; Cntrl : in Control_Type; ControlOut : out int16) return int16 is
      use ASCII;
      pragma inline(Application_Control);
      function to_address is new Ada.Unchecked_Conversion(System.Address, Unsigned_32);
   begin
      control := (0 => 129, 1 => Control_Type'Enum_Rep(Cntrl), 3 => 1, others => 0);
      Asm("move.l       %0,d1"         & LF & HT &
          "move.w       #200,d0"       & LF & HT &
          "trap         #2"            & LF & HT,
          Volatile => True, 
          Inputs => Interfaces.Unsigned_32'Asm_Input("g", to_address(aespb'Address))
      );
      ControlOut := int16(intout(1));
      return int16(intout(0));
   end Application_Control;

   function Application_Find(File_Name : String) return int16 is
   begin
      null;
      return 0;
   end Application_Find;
end GemAes;
