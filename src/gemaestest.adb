with TOS; use TOS;
with GEM.AES; use GEM.AES;
with GEM.AES.Application;
with GEM.AES.Form;
with GEM.AES.Graf;
with GEM.AES.Window;
with GEM.AES.Resource;
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

    Resource_File_Name : constant String := "aestest.rsc";

begin
    Application_Id := Application.Init;
    Physical_Handle := Graf.Handle(Char_Width, Char_Height, Char_Box_Width, Char_Box_Height);
    Desk_Rectangle := Window.Get_Rectangle(0, Window.Work_XYWH);

    if Resource.Load(Resource_File_Name) /= 0 then
        Button := Form.Alert(3, "[3][Hello from Ada][ OK ]");
    else
        Button := Form.Alert(1, "[1][Resource file|" & Resource_File_Name & "|Not found][EXIT]");
    end if;
    Application_Id := Application.AExit;
end GemAESTest;