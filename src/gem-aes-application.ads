
package GEM.AES.Application is
   function Init return Int16;

   -- should be Exit, really, but clashes with reserved word
   function AExit return Int16;
   procedure Bitvector_Set(Floppy_Disk_Vector : Uint16; Hard_Disk_Vector : Uint16);

   -- constants for Application_Control
   type Control_Type is (Apc_Topnext, Apc_Kill, Apc_System, Apc_Hide, Apc_Show, Apc_Top,
                         Apc_Hidenot, Apc_Info, Apc_Menu, Apc_Widgets, Apc_App_Config,
                         Apc_Inform_Mesag);
   for Control_Type use (Apc_Topnext => 0, Apc_Kill => 1, Apc_System => 2, Apc_Hide => 10,
                         Apc_Show => 11, Apc_Top => 12, Apc_Hidenot => 13, Apc_Info => 14,
                         Apc_Menu => 15, Apc_Widgets => 16, Apc_App_Config => 17,
                         Apc_Inform_Mesag => 18);
   function Control(Application_ID : in Int16; C : in Control_Type; ControlOut : out Int16) return Int16;
   function Find(Application_Name : String) return Int16;

   type Application_Info_Type is (Aes_Largefont, Aes_Smallfont, Aes_System, Aes_Language, Aes_Process,
                                  Aes_Pcgem, Aes_Inquire, Aes_Reserved, Aes_Mouse, Aes_Menu, Aes_Shell,
                                  Aes_Window, Aes_Message, Aes_Object, Aes_Form, Aes_Extended,
                                  Aes_Naes, Aes_Version, Aes_Wf_Opts, Aes_Extended_Functions,
                                  Aes_Application_Options, Aes_Winx, Aes_Xaaes);
   for Application_Info_Type use (Aes_Largefont => 0, Aes_Smallfont => 1, Aes_System => 2,
                                  Aes_Language => 3, Aes_Process => 4, Aes_Pcgem => 5, Aes_Inquire => 6,
                                  Aes_Reserved => 7, Aes_Mouse => 8, Aes_Menu => 9, Aes_Shell => 10,
                                  Aes_Window => 11, Aes_Message => 12, Aes_Object => 13, Aes_Form => 14,
                                  Aes_Extended => 64, Aes_Naes => 65, Aes_Version => 96, Aes_Wf_Opts => 97,
                                  Aes_Extended_Functions => 98, Aes_Application_Options => 99,
                                  Aes_Winx => 22360, Aes_Xaaes => 22528);

   function Get_Info(Application_Get_What : Application_Info_Type;
                     Ap_Out1, Ap_Out2, Ap_Out3, Ap_Out4 : out Int16) return Int16;
   function Read(Application_Id : Int16; Read_Length : Int16; Buff : out Uint16_Array_Type) return Int16;
   function Search(Search_Mode : Int16; Name : String; Application_Type, Application_Id : out Int16) return Int16;
end GEM.AES.Application;
