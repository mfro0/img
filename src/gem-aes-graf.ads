with System;
with System.Machine_Code; use System.Machine_Code;
with Interfaces; use Interfaces;
with Interfaces.C.Strings;
with Ada.Unchecked_Conversion;
with Ada.Text_IO; use Ada.Text_IO;

package GEM.AES.Graf is
    function Handle(Char_Width, Char_Height, Char_Box_Width, Char_Box_Height : out Int16) return Int16;

    type Mouse_Type is (Arrow,
                        Text_Cursor,
                        Hourglass,
                        Point_Hand,
                        Flat_Hand,
                        Thin_Cross,
                        Thick_Cross,
                        Outline_Cross,
                        Left_Right_Arrow,
                        Up_Down_Arrow,
                        User_Defined,
                        Off,
                        On,
                        Save,
                        Restore,
                        Last,
                        Bubble_Disc,
                        Resizer,
                        NE_Resizer,
                        Mover,
                        Vertical_Sizer,
                        Horizontal_Sizer,
                        Point_Slider,
                        Reset,
                        Get,
                        Set_Shape);
    for Mouse_Type use (Arrow => 0,
                        Text_Cursor => 1,
                        Hourglass => 2,
                        Point_Hand => 3,
                        Flat_Hand => 4,
                        Thin_Cross => 5,
                        Thick_Cross => 6,
                        Outline_Cross => 7,
                        Left_Right_Arrow => 8,
                        Up_Down_Arrow => 9,
                        User_Defined => 255,
                        Off => 256,
                        On => 257,
                        Save => 258,
                        Restore => 259,
                        Last => 260,
                        Bubble_Disc => 270,
                        Resizer => 271,
                        NE_Resizer => 272,
                        Mover => 273,
                        Vertical_Sizer => 274,
                        Horizontal_Sizer => 275,
                        Point_Slider => 276,
                        Reset => 1000,
                        Get => 1001,
                        Set_Shape => 1100);

    procedure Mouse(Form : Mouse_Type);
end GEM.AES.Graf;