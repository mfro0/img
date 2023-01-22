with GEM.AES;
with GEM.AES.Window;
with GEM.AES.Graf;

package body OGEM is
    procedure Full(Self : OWindow) is
    begin
        null;
    end Full;

    procedure Size(Self : OWindow; X, Y, W, H : Int16) is
    begin
        null;
    end Size;

    procedure Size(Self : OWindow; R : GEM.AES.Rectangle) is
    begin
        Self.Size(R.X, R.Y, R.W, R.H);
    end Size;
    
    procedure Draw(Self : OWindow; X, Y, W, H : Int16) is
    begin
        null;
    end Draw;

    procedure Delete(Self : OWindow) is
    begin
        null;
    end Delete;

    procedure Open(Self : in out OWindow; X, Y, W, H : Int16) is
    begin
        GEM.AES.Graf.Grow_Box(10, 10, 10, 10, X, Y, W, H);
        GEM.AES.Window.Open(Self.Handle, X, Y, W, H);

        Self.Work := GEM.AES.Window.Get(Self.Handle, GEM.AES.Window.Work_XYWH);
        Self.Rect := GEM.AES.Window.Get(Self.Handle, GEM.AES.Window.Current_XYWH);
    end Open;

    procedure Open(Self : in out OWindow; R : GEM.AES.Rectangle) is
    begin
        Self.Open(R.X, R.Y, R.W, R.H);
    end Open;

    procedure Clear(Self : OWindow; X, Y, W, H : Int16) is
    begin
        null;
    end Clear;

    procedure Scroll(Self : OWindow) is
    begin
        null;
    end Scroll;

    procedure Timer(Self : OWindow) is
    begin
        null;
    end Timer;
end OGEM;
