with GEM.AES; use GEM.AES;
with GEM.AES.Object;
with GEM.AES.Resource;

package GEM.AES.Form is
   function Alert(Default_Button : in Int16; Alert_String : String) return Int16;

   type Dialog_Flag is (Dialog_Start, Dialog_Grow, Dialog_Shrink, Dialog_Finish);

   procedure Dial(What : Dialog_Flag; X0, Y0, W0, H0, X1, Y1, W1, H1 : Int16);
   procedure Dial(What : Dialog_Flag; R0, R1 : GEM.AES.Rectangle);

   -- "Do" is a reserved word in Ada, so unfortunately we can't use it here
   -- function Form_Do(Tree_Ptr : GEM.AES.Object.Tree_P; Start_Index : Int16) return Int16;
end GEM.AES.Form;