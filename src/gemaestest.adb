with Gem_AES; use Gem_AES;
with Gem_AES.Application;
with Gem_AES.Form;

procedure GemAESTest is
    Application_Id      : Int16;
    Button              : Int16;
begin
    Application_Id := Gem_AES.Application.Init;
    Button := Gem_AES.Form.Alert(3, "[3][Hello from Ada][ OK ]");
    Application_Id := Gem_AES.Application.AExit;
end GemAesTest;