package body GEM.AES.Event is

   function Multi
      (flags :     Event_Type; Mouse_Button_Clicks : Int16;
       Mouse_Button_Mask :     Int16; Mouse_Button_State : Int16;
       Enter_Leave_1                                   :     Boolean;
       Mouse1_X, Mouse1_Y, Mouse1_Width, Mouse1_Height :     Int16;
       Enter_Leave_2                                   :     Boolean;
       Mouse2_X, MOuse2_Y, Mouse2_Width, Mouse2_Height :     Int16;
       Message :     Message_Buffer; Timer_Low, Timer_High : Int16;
       Mouse_X, Mouse_Y                                : out Int16;
       Key_State, Key_Return, Mouse_Return : out Int16) return Event_Type
   is
   begin
      -- return Keyboard in Message;
      return Mouse_1;
   end Multi;

   type Multi_Record is record
      Mouse_Button_Clicks                             : Int16;
      Mouse_Button_Mask                               : Int16;
      Mouse_Button_State                              : Int16;
      Enter_Leave_1                                   : Boolean;
      Mouse1_X, Mouse1_Y, Mouse1_Width, Mouse1_Height : Int16;
      Enter_Leave_2                                   : Boolean;
      Mouse2_X, MOuse2_Y, Mouse2_Width, Mouse2_Height : Int16;
      Message                                         : Message_Buffer;
      Timer_Low, Timer_High                           : Int16;
   end record;
end GEM.AES.Event;
