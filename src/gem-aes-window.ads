with System;
with System.Machine_Code; use System.Machine_Code;
with Interfaces; use Interfaces;
with Interfaces.C.Strings;
with Ada.Unchecked_Conversion;
with Ada.Text_IO; use Ada.Text_IO;
with GEM.AES;

package GEM.AES.Window is
    type Action_Type is (Kind,                      -- WF_KIND
                         Name,                      -- WF_NAME
                         Info,                      -- WF_INFO
                         Work_XYWH,                 -- WF_WORKXYWH
                         Current_XYWH,              -- WF_CURRXYWH
                         Previous_XYWH,             -- WF_PREVXYWH
                         Full_XYWH,                 -- WF_FULLXYWH
                         Horizontal_Slider,         -- WF_HSLIDE
                         Vertical_Slider,           -- WF_VSLIDE
                         Top,                       -- WF_TOP
                         First_XYWH,                -- WF_FIRSTXYWH
                         Next_XYWH,                 -- WF_NEXTXYWH
                         New_Desk,                  -- WF_NEWDESK
                         Horizontal_Slider_Size,    -- WF_HSLSIZE
                         Vertical_Slider_Size,      -- WF_VSLSIZE
                         Screen,                    -- WF_SCREEN
                         D_Color,                   -- WF_DCOLOR
                         Owner,                     -- WF_OWNER
                         Event_Bitvector,           -- WF_BEVENT
                         Bottom,                    -- WF_BOTTOM
                         Iconify,                   -- WF_ICONIFY
                         Un_Iconify,                -- WF_UNICONIFY
                         Toolbar,                   -- WF_TOOLBAR
                         First_Toolbar,             -- WF_FTOOLBAR
                         Next_Toolbar,              -- WF_NTOOLBAR
                         Menu,                      -- WF_MENU
                         Options,                   -- WF_OPTS
                         M_Owner,                   -- WF_MOWNER
                         M_Window_List,             -- WF_M_WINDLIST
                         Min_XYWH,                  -- WF_MINXYWH
                         Info_XYWH,                 -- WF_INFOXYWH
                         Widgets,                   -- WF_WIDGETS
                         User_Pointer,              -- WF_USER_POINTER
                         Bitmap,                    -- WF_BITMAP
                         Winx,                      -- WF_WINX
                         Winx_Cfg,                  -- WF_WINXCFG
                         D_Delay,                   -- WF_DDELAY
                         Shade,                     -- WF_SHADE
                         Xa                         -- XA 
                        );
    for Action_Type use 
                        (Kind => 1,
                         Name => 2,
                         Info => 3,
                         Work_XYWH => 4,
                         Current_XYWH => 5,
                         Previous_XYWH => 6,
                         Full_XYWH => 7,
                         Horizontal_Slider => 8,
                         Vertical_Slider => 9,
                         Top => 10,
                         First_XYWH => 11,
                         Next_XYWH => 12,
                         New_Desk => 14,
                         Horizontal_Slider_Size => 15,
                         Vertical_Slider_Size => 16,
                         Screen => 17,
                         D_Color => 19,
                         Owner => 20,
                         Event_Bitvector => 24,
                         Bottom => 25,
                         Iconify => 26,
                         Un_Iconify => 27,
                         Toolbar => 30,
                         First_Toolbar => 31,
                         Next_Toolbar => 32,
                         Menu => 33,
                         Options => 41,
                         M_Owner => 101,
                         M_Window_List => 102,
                         Min_XYWH => 103,
                         Info_XYWH => 104,
                         Widgets => 200,
                         User_Pointer => 230,
                         Bitmap => 233,
                         Winx => 22360,
                         Winx_Cfg => 22361,
                         D_Delay => 22362,
                         Shade => 22365,
                         Xa => 16#5841#
                        );                                               
    function Get(Handle : Int16; What : Action_Type) return Rectangle;

    procedure Open(Handle : Int16; X, Y, W, H : Int16);
    procedure Open(Handle : Int16; Area : AES.Rectangle);
end GEM.AES.Window;