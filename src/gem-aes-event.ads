
package GEM.AES.Event is

   type Event_Type is (Keyboard, Button, Mouse_1, Mouse_2, Message, Timer, Wheel, Mouse_Mx, Keyboard_4, Dialog);
   for Event_Type use (
      Keyboard => 16#1#,
      Button => 16#2#,
      Mouse_1 => 16#4#,
      Mouse_2 => 16#8#,
      Message => 16#10#,
      Timer => 16#20#,
      Wheel => 16#40#,
      Mouse_Mx => 16#80#,
      Keyboard_4 => 16#100#,
      Dialog => 16#4000#
   );

Type Message_Buffer is array(Integer range 0 .. 15) of Int16;
function Multi(flags : Event_Type;
               Mouse_Button_Clicks : Int16; Mouse_Button_Mask : Int16; Mouse_Button_State : Int16;
               Enter_Leave_1 : Boolean;
               Mouse1_X, Mouse1_Y, Mouse1_Width, Mouse1_Height : Int16;
               Enter_Leave_2 : Boolean;
               Mouse2_X, MOuse2_Y, Mouse2_Width, Mouse2_Height : Int16;
               Message : Message_Buffer;
               Timer_Low,
               Timer_High : Int16;
               Mouse_X, Mouse_Y : out Int16;
               Key_State, Key_Return, Mouse_Return : out Int16
              ) return Event_Type;
end GEM.AES.Event;