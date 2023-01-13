with Interfaces.C;

package GemAes is
   -- constants for GEM AES calls
   type int16 is new integer range -2 ** 16 .. 2 ** 16 - 1;
   type uint16 is new Interfaces.Unsigned_16;

   function Application_Init return int16;
   function Application_Exit return int16;
   function Form_Alert(default_button : in int16; alert_string : in String) return int16;
end GemAes;
