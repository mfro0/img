with TOS; use TOS;
with GEM.AES; use GEM.AES;
with GEM.AES.Application;
with GEM.AES.Form;
with GEM.AES.Graf;
with GEM.AES.Window;
with GEM.AES.Resource;
with GEM.AES.Event;
with GEM.AES.Object;
with Ada.Unchecked_Conversion;
with Ada.Integer_Text_IO;
with aestest; use aestest;
with Ada.Exceptions;

with Ada.Text_IO;

with OGEM; use OGEM;
with System; use System;

procedure GemAESTest is
   Application_Id      : GEM.AES.Application.App_Id_Type;
   Button              : Int16;
   Physical_Handle     : Int16;

   Char_Width,
   Char_Height,
   Char_Box_Width,
   Char_Box_Height     : Int16;

   Desk_Rectangle      : GEM.AES.Rectangle;
   Resource_File_Name : constant String := "aestest.rsc";
   
   -- type Object_Array is array (natural range <>) of GEM.AES.Object.Resource_Object
   --   with Convention => C;
   -- type Tree_T is new Object_Array;
   type Tree_Ptr is new System.Address;
   -- pragma No_Strict_Aliasing(Tree_Ptr);
   
   -- type Object_Array_Ptr is access Object_Array;
   -- type Object_Ptr is access GEM.AES.Object.Resource_Object;
   -- pragma No_Strict_Aliasing(Object_Ptr);

   procedure Get_Tree is new GEM.AES.Resource.Get_Address(Resource => Tree_Ptr);
   -- function Get_Object is new GEM.AES.Resource.Get_Address(Resource => Object_Ptr);
   -- function To_Integer is new Ada.Unchecked_Conversion(Tree_Ptr, Integer);
   ret : Int16;
   -- Tree_P : Tree_Ptr;

   Start_Rectangle, End_Rectangle : GEM.AES.Rectangle;
begin
   Application_Id := Application.Init;
   Physical_Handle := Graf.Handle(Char_Width, Char_Height, Char_Box_Width, Char_Box_Height);
   Desk_Rectangle := GEM.AES.Window.Get(0, Window.Work_XYWH);
   
      Resource.Load(Resource_File_Name);
      Button := Form.Alert(3, "[3][Hello from Ada][ OK ]");
      -- Get_Tree(GEM.AES.Resource.Tree, ABOUT, Tree_P);

      -- Start_Rectangle := (Tree_P.all(ABOUT).Ob_X, Tree_P.all(ABOUT).Ob_Y,
      --                  Tree_P.all(ABOUT).Ob_Width, Tree_P.all(ABOUT).Ob_Height);
      -- End_Rectangle := Start_Rectangle;

      -- reserve screen space for dialog
      -- GEM.AES.Form.Dial(GEM.AES.Form.Dialog_Start, Start_Rectangle, End_Rectangle);
      -- draw growing rectangle
      -- GEM.AES.Form.Dial(GEM.AES.Form.Dialog_Grow, Start_Rectangle, End_Rectangle);

      -- GEM.AES.Form.Form_Do(Tree_P, GEM.AES.Object.Root);

      -- Ada.Text_IO.Put("Tree_P =");
      -- Ada.Integer_Text_IO.Put(To_Integer(Tree_P), Base => 16);
      -- Ada.Text_IO.Put_Line(ASCII.CR & ASCII.LF);
      -- Ada.Text_IO.Put("Flags(0) = ");
      -- Ada.Integer_Text_IO.Put(Tree_P.all(0).Ob_Flags);
      -- Ada.Text_IO.Put_Line(ASCII.CR & ASCII.LF);
      -- Ada.Text_IO.Put("State(0) =");
      -- Ada.Integer_Text_IO.Put(Tree_P.all(0).Ob_State, Base => 16);
      -- Ada.Text_IO.Put_Line(ASCII.CR & ASCII.LF);
      -- Ada.Text_IO.Put("Flags(10) =");
      -- Ada.Integer_Text_IO.Put(Tree_P.all(10).Ob_Flags, Base => 16);
   -- else
      -- Button := Form.Alert(1, "[1][Resource file|" & Resource_File_Name & "|Not found][EXIT]");
   -- Ada.Text_IO.Put_Line()
   Application.AExit;
exception
   when E : AES_Exception =>
      Ada.Text_IO.Put_Line(Ada.Exceptions.Exception_Message(E));
end GemAESTest;
