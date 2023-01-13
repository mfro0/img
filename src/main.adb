with Ada.Text_IO; use Ada.Text_IO;
with GemAes;
with System;

procedure Main is
   application_id       : GemAes.int16;
   alert_return         : GemAes.int16;

begin
   application_id := GemAes.Application_Init;
   alert_return := GemAes.Form_Alert(0, "[0][Hello from GemAES Ada|][OK]");
   application_id := GemAes.Application_Exit;
end Main;

