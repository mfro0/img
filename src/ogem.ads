with TOS; use TOS;
with GEM.AES;
package OGEM is
    type OWindow is tagged record
        Class           : Uint32;
        Handle          : Int16;
        Kind            : Uint32;
        Word_Aligned    : Boolean;

        Rect,
        Work,
        Old             : GEM.AES.Rectangle;

        Left,
        Top             : Int32;    -- Start of viewing rect in document
        Doc_Width,
        Doc_Height      : Int32;

        X_Fac,
        Y_Fac           : Int32;

        Is_Open,
        Is_Topped,
        Is_Fulled       : Boolean;

        Name,
        Info            : String(1 .. 200);
    end record;

    procedure Full(Self : OWindow);
    procedure Size(Self : OWindow; X, Y, W, H : Int16);
    procedure Draw(Self : OWindow; X, Y, W, H : Int16);
    procedure Delete(Self : OWindow);
    procedure Open(Self : in out OWindow; X, Y, W, H : Int16);
    procedure Open(Self : in out OWindow; R : GEM.AES.Rectangle);
    procedure Clear(Self : OWindow; X, Y, W, H : Int16);
    procedure Scroll(Self : OWindow);
    procedure Timer(Self : OWindow);
    
end OGEM;