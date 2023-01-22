with GEM.AES;
with GEM.AES.Window;
with GEM.AES.Graf;

package body OGEM is
    Desk_Rectangle : GEM.AES.Rectangle := GEM.AES.Window.Get(0, GEM.AES.Window.Current_XYWH);

    procedure Full(Self : in out OWindow) is
    begin
        if Self.Is_Fulled then
            GEM.AES.Window.Calc(GEM.AES.Window.Calc_Work, 
                                Self.Kind, 
                                Self.Old, Self.Work);
            GEM.AES.Window.Set(Self.Handle,
                               GEM.AES.Window.Current_XYWH, Self.Rect);
        else
            GEM.AES.Window.Calc(GEM.AES.Window.Calc_Border, 
                                Self.Kind, 
                                Self.Work, Self.Old);
            GEM.AES.Window.Calc(GEM.AES.Window.Calc_Work, 
                                Self.Kind, Desk_Rectangle, Self.Work);
            GEM.AES.Window.Set(Self.Handle, GEM.AES.Window.Current_XYWH, Desk_Rectangle);    
        end if;
        Self.Rect := GEM.AES.Window.Get(Self.Handle, GEM.AES.Window.Current_XYWH);
        Self.Rect := GEM.AES.Window.Get(Self.Handle, GEM.AES.Window.Work_XYWH);
    end Full;

    procedure Size(Self : in out OWindow; X, Y, W, H : Int16) is
    begin
        -- if W < GEM.AES.Window.Minimum_Width then
        --    W := GEM.AES.Window.Minimum_Width;
        -- end if;
        -- if H < GEM.AES.Window.Minimum_Height then
        --     H := GEM.AES.Window.Minimum_Height;
        -- end if;
        GEM.AES.Window.Set(Self.Handle, GEM.AES.Window.Current_XYWH, GEM.AES.Rectangle'(X, Y, W, H));
        Self.Work := GEM.AES.Window.Get(Self.Handle, GEM.AES.Window.Work_XYWH);
        Self.Rect := GEM.AES.Window.Get(Self.Handle, GEM.AES.Window.Current_XYWH);
        Scroll(Self);
    end Size;

    procedure Size(Self : in out OWindow; R : GEM.AES.Rectangle) is
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
