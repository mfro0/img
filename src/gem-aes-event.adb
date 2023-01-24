package body GEM.AES.Event is
   function Multi(flags : Event_Type; Rec : in out Multi_Record) return Event_Type is
   begin
      return Message;
   end Multi;

   function Multi(flags : Event_Type;
                  Mouse_Button_Clicks : Int16; Mouse_Button_Mask : Int16; Mouse_Button_State : Int16;
                  Enter_Leave1 : Boolean;
                  Mouse1_X, Mouse1_Y, Mouse1_Width, Mouse1_Height : Int16;
                  Enter_Leave2 : Boolean;
                  Mouse2_X, MOuse2_Y, Mouse2_Width, Mouse2_Height : Int16;
                  Message_Buf : out Message_Buffer;
                  Timer_Low,
                  Timer_High : Int16;
                  Mouse_X, Mouse_Y : out Int16;
                  Key_State, Key_Return, Mouse_Return : out Int16
               ) return Event_Type is
   begin
      return Message;
   end Multi;

end GEM.AES.Event;
