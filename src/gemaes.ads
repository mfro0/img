with Interfaces.C;

package GemAes is
   -- constants for GEM AES calls
   type int16 is new integer range -2 ** 16 .. 2 ** 16 - 1;
   type uint16 is new Interfaces.Unsigned_16;

   function Application_Init return int16;
   function Application_Exit return int16;
   function Form_Alert(default_button : in int16; alert_string : in String) return int16;
   procedure Application_Bitvector_Set(Floppy_Disk_Vector : uint16; Hard_Disk_Vector : uint16);

   -- constants for Application_Control
   type Control_Type is (APC_TOPNEXT, APC_KILL, APC_SYSTEM, APC_HIDE, APC_SHOW, APC_TOP,
                         APC_HIDENOT, APC_INFO, APC_MENU, APC_WIDGETS, APC_APP_CONFIG,
                         APC_INFORM_MESAG);
   for Control_Type use (APC_TOPNEXT => 0, APC_KILL => 1, APC_SYSTEM => 2, APC_HIDE => 10,
                         APC_SHOW => 11, APC_TOP => 12, APC_HIDENOT => 13, APC_INFO => 14,
                         APC_MENU => 15, APC_WIDGETS => 16, APC_APP_CONFIG => 17,
                         APC_INFORM_MESAG => 18);
   function Application_Control(Application_ID : in int16; Cntrl : in Control_Type; ControlOut : out int16) return int16;

end GemAes;
