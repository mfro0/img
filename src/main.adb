with Ada.Text_IO; use Ada.Text_IO;
with Gem_Aes.Application;
with Gem_AES.Form;
with System;

procedure Main is
   Application_ID       : Gem_AES.Int16;
   Alert_Return         : Gem_AES.Int16;

begin
   Application_ID := Gem_AES.Application.Init;
   Alert_Return := Gem_AES.Form.Alert(0, "[0][Hello from GemAES Ada|][OK]");
   Application_ID := Gem_AES.Application.AExit;
end Main;

