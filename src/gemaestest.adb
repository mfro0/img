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

with Ada.Text_IO;

with OGEM; use OGEM;

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
   
   type Object_Array is array (natural range <>) of GEM.AES.Object.Resource_Object
      with Convention => C;
   type Tree_T is new Object_Array(0 .. Num_Objects);
   type Tree_Ptr is access Tree_T;
   pragma No_Strict_Aliasing(Tree_Ptr);
   
   type Object_Array_Ptr is access Object_Array;
   type Object_Ptr is access GEM.AES.Object.Resource_Object;
   pragma No_Strict_Aliasing(Object_Ptr);

   function Get_Tree is new GEM.AES.Resource.Get_Address(Resource => Tree_Ptr);
   function Get_Object is new GEM.AES.Resource.Get_Address(Resource => Object_Ptr);
   function To_Integer is new Ada.Unchecked_Conversion(Tree_Ptr, Integer);
   ret : Int16;
   Tree_P : Tree_Ptr;

begin
   Application_Id := Application.Init;
   Physical_Handle := Graf.Handle(Char_Width, Char_Height, Char_Box_Width, Char_Box_Height);
   Desk_Rectangle := GEM.AES.Window.Get(0, Window.Work_XYWH);
   
   if Resource.Load(Resource_File_Name) /= 0 then
      -- Button := Form.Alert(3, "[3][Hello from Ada][ OK ]");
      ret := Get_Tree(GEM.AES.Resource.Tree, 0, Tree_P);
      Ada.Text_IO.Put("Tree_P =");
      Ada.Integer_Text_IO.Put(To_Integer(Tree_P), Base => 16);
      Ada.Text_IO.Put_Line(ASCII.CR & ASCII.LF);
      Ada.Text_IO.Put("Flags(0) = ");
      Ada.Integer_Text_IO.Put(Tree_P.all(0).Ob_Flags);
      Ada.Text_IO.Put_Line(ASCII.CR & ASCII.LF);
      Ada.Text_IO.Put("State(0) =");
      Ada.Integer_Text_IO.Put(Tree_P.all(0).Ob_State, Base => 16);
      Ada.Text_IO.Put_Line(ASCII.CR & ASCII.LF);
      Ada.Text_IO.Put("Flags(10) =");
      Ada.Integer_Text_IO.Put(Tree_P.all(10).Ob_Flags, Base => 16);
   else
      Button := Form.Alert(1, "[1][Resource file|" & Resource_File_Name & "|Not found][EXIT]");
   end if;
   -- Ada.Text_IO.Put_Line()
   Application_Id := Application.AExit;
end GemAESTest;