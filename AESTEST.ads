--
--  resource set indices for aestest
--
--  created by ORCS 2.18
--


with Atari; use Atari;

package aestest is

--  constants

    Num_Strings: constant int16 :=        74;
    Num_Bitblks: constant int16 :=        1;
    Num_Iconblks: constant int16 :=       7;
    Num_Color_Iconblks: constant int16 := 1;
    Num_Color_Icons: constant int16 :=    4;
    Num_Tedinfos: constant int16 :=       3;
    Num_Free_Strings: constant int16 :=   2;
    Num_Free_Images: constant int16 :=    1;
    Num_Objects: constant int16 :=        95;
    Num_Trees: constant int16 :=          5;
    Num_Userdefs: constant int16 :=       0;

--  object numbers


    MMENU           : constant int16 :=   0; --  menu
    MMENU_MACC      : constant int16 :=   3; --  TITLE in tree MMENU
    MMENU_MFILE     : constant int16 :=   4; --  TITLE in tree MMENU
    MMENU_MEDIT     : constant int16 :=   5; --  TITLE in tree MMENU
    MMENU_MABOUT    : constant int16 :=   8; --  STRING in tree MMENU
    MMENU_MNGRAFWI  : constant int16 :=  17; --  STRING in tree MMENU
    MN_OFFSCREEN    : constant int16 :=  18; --  STRING in tree MMENU
    MMENU_MTEST     : constant int16 :=  19; --  STRING in tree MMENU
    MMENU_MNCOMPLE  : constant int16 :=  20; --  STRING in tree MMENU
    BEZIERWIN       : constant int16 :=  21; --  STRING in tree MMENU
    MMENU_MNBACKB   : constant int16 :=  22; --  STRING in tree MMENU
    MMENU_RCIRCLES  : constant int16 :=  23; --  STRING in tree MMENU
    MMENU_NVDIRC    : constant int16 :=  24; --  STRING in tree MMENU
    MMENU_MNVDI     : constant int16 :=  25; --  STRING in tree MMENU
    MMENU_MNCUBE    : constant int16 :=  26; --  STRING in tree MMENU
    MMENU_MNCLOCK   : constant int16 :=  27; --  STRING in tree MMENU
    MNU_FONTWIN     : constant int16 :=  28; --  STRING in tree MMENU
    MN_ROT          : constant int16 :=  29; --  STRING in tree MMENU
    MN_TERRAIN      : constant int16 :=  30; --  STRING in tree MMENU
    MMENU_MCLOSE    : constant int16 :=  31; --  STRING in tree MMENU
    MMENU_MQUIT     : constant int16 :=  34; --  STRING in tree MMENU
    MMENU_WINOPTS   : constant int16 :=  35; --  BOX in tree MMENU
    MMENU_MPREFS    : constant int16 :=  36; --  STRING in tree MMENU
    MMENU_COLORS    : constant int16 :=  38; --  STRING in tree MMENU

    PREFS           : constant int16 :=   1; --  form/dialog
    PREF_OK         : constant int16 :=   1; --  BUTTON in tree PREFS
    PREF_CANCEL     : constant int16 :=   2; --  BUTTON in tree PREFS
    PREFS_PUPTEST1  : constant int16 :=   3; --  BUTTON in tree PREFS
    PREFS_PUPTEST2  : constant int16 :=   4; --  BUTTON in tree PREFS

    ABOUT           : constant int16 :=   2; --  form/dialog
    ABO_OK          : constant int16 :=   5; --  BUTTON in tree ABOUT

    POPUPS          : constant int16 :=   3; --  form/dialog
    POPUP_STRINGS   : constant int16 :=   1; --  BOX in tree POPUPS
    POPUP_ITEM1     : constant int16 :=   2; --  STRING in tree POPUPS
    POPUP_ITEM2     : constant int16 :=   3; --  STRING in tree POPUPS
    POPUP_ITEM3     : constant int16 :=   4; --  STRING in tree POPUPS
    POPUP_ITEM4     : constant int16 :=   5; --  STRING in tree POPUPS
    POPUP_ITEM5     : constant int16 :=   6; --  STRING in tree POPUPS
    POPUP_ITEM6     : constant int16 :=   7; --  STRING in tree POPUPS
    POPUP_ITEM7     : constant int16 :=   8; --  STRING in tree POPUPS
    POPUP_ITEM8     : constant int16 :=   9; --  STRING in tree POPUPS
    POPUP_ITEM9     : constant int16 :=  10; --  STRING in tree POPUPS
    POPUP_ITEM10    : constant int16 :=  11; --  STRING in tree POPUPS
    POPUP_ITEM11    : constant int16 :=  12; --  STRING in tree POPUPS
    POPUP_ITEM12    : constant int16 :=  13; --  STRING in tree POPUPS
    POPUP_ITEM13    : constant int16 :=  14; --  STRING in tree POPUPS
    POPUP_ITEMS14   : constant int16 :=  15; --  STRING in tree POPUPS
    POPUP_ITEM15    : constant int16 :=  16; --  STRING in tree POPUPS
    POPUP_ITEM16    : constant int16 :=  17; --  STRING in tree POPUPS
    POPUP_ITEM17    : constant int16 :=  18; --  STRING in tree POPUPS
    POPUP_ICONS     : constant int16 :=  19; --  BOX in tree POPUPS
    POPUP_ICON1     : constant int16 :=  20; --  ICON in tree POPUPS
    POPUP_ICON2     : constant int16 :=  21; --  ICON in tree POPUPS
    POPUP_ICON3     : constant int16 :=  22; --  ICON in tree POPUPS
    POPUP_ICON4     : constant int16 :=  23; --  ICON in tree POPUPS
    POPUP_ICON5     : constant int16 :=  24; --  ICON in tree POPUPS
    POPUP_ICON6     : constant int16 :=  25; --  ICON in tree POPUPS
    POPUP_ICON7     : constant int16 :=  26; --  ICON in tree POPUPS
    POPUP_COLORS    : constant int16 :=  27; --  BOX in tree POPUPS
    POPUP_WHITE     : constant int16 :=  28; --  BOX in tree POPUPS
    POPUP_RED       : constant int16 :=  29; --  BOX in tree POPUPS
    POPUP_GREEN     : constant int16 :=  30; --  BOX in tree POPUPS
    POPUP_BLUE      : constant int16 :=  31; --  BOX in tree POPUPS
    POPUP_CYAN      : constant int16 :=  32; --  BOX in tree POPUPS
    POPUP_YELLOW    : constant int16 :=  33; --  BOX in tree POPUPS
    POPUP_MAGENTA   : constant int16 :=  34; --  BOX in tree POPUPS
    POPUP_LIGHTGREY : constant int16 :=  35; --  BOX in tree POPUPS
    POPUP_DARKGREY  : constant int16 :=  36; --  BOX in tree POPUPS
    POPUP_DARKRED   : constant int16 :=  37; --  BOX in tree POPUPS
    POPUP_DARKGREEN : constant int16 :=  38; --  BOX in tree POPUPS
    POPUP_DARKBLUE  : constant int16 :=  39; --  BOX in tree POPUPS
    POPUP_DARKCYAN  : constant int16 :=  40; --  BOX in tree POPUPS
    POPUP_DARKYELLOW: constant int16 :=  41; --  BOX in tree POPUPS
    POPU_DARKMAGENTA: constant int16 :=  42; --  BOX in tree POPUPS

    ICNS            : constant int16 :=   4; --  form/dialog
    COLICON         : constant int16 :=   1; --  CICON in tree ICNS

    ALERT1          : constant int16 :=   0; --  Alert string

    STR             : constant int16 :=   1; --  Free string

    RASTER          : constant int16 :=   0; --  Free image




end aestest;
