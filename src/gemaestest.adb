with Gem_AES; use Gem_AES;
with Gem_AES.Application;
with Gem_AES.Form;
with Gem_AES.Graf;
with Gem_AES.Window;
with Ada.Text_IO;

procedure GemAESTest is
    Application_Id      : Int16;
    Button              : Int16;
    Physical_Handle     : Int16;

    Char_Width,
    Char_Height,
    Char_Box_Width,
    Char_Box_Height     : Int16;

    Desk_Rectangle      : Gem_AES.Rectangle;
begin
    Application_Id := Gem_AES.Application.Init;
    --Physical_Handle := Gem_AES.Graf.Handle(Char_Width, Char_Height, Char_Box_Width, Char_Box_Height);
    Desk_Rectangle := Gem_AES.Window.Get_Rectangle(0, Window.Work_XYWH);
    Ada.Text_IO.Put_Line("Desk.X=" & Integer'Image(Integer(Desk_Rectangle.X)) &
                         " Desk.Y=" & Integer'Image(Integer(Desk_Rectangle.Y)) &
                         " Desk.W=" & Integer'Image(Integer(Desk_Rectangle.W)) &
                         " Desk.H=" & Integer'Image(Integer(Desk_Rectangle.H)));
    Gem_AES.Graf.Mouse(Graf.Arrow);

    Button := Gem_AES.Form.Alert(3, "[3][Hello from Ada][ OK ]");
    Application_Id := Gem_AES.Application.AExit;
end GemAesTest;