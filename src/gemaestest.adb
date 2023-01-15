with GEM.AES; use GEM.AES;
with GEM.AES.Application;
with GEM.AES.Form;
with GEM.AES.Graf;
with GEM.AES.Window;
with Ada.Text_IO;

procedure GemAESTest is
    Application_Id      : Int16;
    Button              : Int16;
    Physical_Handle     : Int16;

    Char_Width,
    Char_Height,
    Char_Box_Width,
    Char_Box_Height     : Int16;

    Desk_Rectangle      : GEM.AES.Rectangle;
begin
    Application_Id := GEM.AES.Application.Init;
    Physical_Handle := GEM.AES.Graf.Handle(Char_Width, Char_Height, Char_Box_Width, Char_Box_Height);
    Desk_Rectangle := GEM.AES.Window.Get_Rectangle(0, Window.Work_XYWH);

    Button := GEM.AES.Form.Alert(3, "[3][Hello from Ada][ OK ]");
    Application_Id := GEM.AES.Application.AExit;
end GemAESTest;