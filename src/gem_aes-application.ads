
package Gem_AES.Application is
   function Init return Int16;

   -- should be Exit really, but clashes with reserved word
   function AExit return Int16;
   procedure Bitvector_Set(Floppy_Disk_Vector : Uint16; Hard_Disk_Vector : Uint16);

   -- constants for Application_Control
   type Control_Type is (Apc_Topnext, Apc_Kill, Apc_System, Apc_Hide, Apc_Show, Apc_Top,
                         Apc_Hidenot, Apc_Info, Apc_Menu, Apc_Widgets, Apc_App_Config,
                         Apc_Inform_Mesag);
   for Control_Type use (APC_TOPNEXT => 0, APC_KILL => 1, APC_SYSTEM => 2, APC_HIDE => 10,
                         APC_SHOW => 11, APC_TOP => 12, APC_HIDENOT => 13, APC_INFO => 14,
                         APC_MENU => 15, APC_WIDGETS => 16, APC_APP_CONFIG => 17,
                         APC_INFORM_MESAG => 18);
   function Control(Application_ID : in Int16; C : in Control_Type; ControlOut : out Int16) return Int16;
   function Find(Application_Name : String) return Int16;

   type Application_Info_Type is (AES_LARGEFONT, AES_SMALLFONT, AES_SYSTEM, AES_LANGUAGE, AES_PROCESS,
                                  AES_PCGEM, AES_INQUIRE, AES_RESERVED, AES_MOUSE, AES_MENU, AES_SHELL,
                                  AES_WINDOW, AES_MESSAGE, AES_OBJECT, AES_FORM, AES_EXTENDED,
                                  AES_NAES, AES_VERSION, AES_WF_OPTS, AES_EXTENDED_FUNCTIONS,
                                  AES_APPLICATION_OPTIONS, AES_WINX, AES_XAAES);
   for Application_Info_Type use (AES_LARGEFONT => 0, AES_SMALLFONT => 1, AES_SYSTEM => 2,
                                  AES_LANGUAGE => 3, AES_PROCESS => 4, AES_PCGEM => 5, AES_INQUIRE => 6,
                                  AES_RESERVED => 7, AES_MOUSE => 8, AES_MENU => 9, AES_SHELL => 10,
                                  AES_WINDOW => 11, AES_MESSAGE => 12, AES_OBJECT => 13, AES_FORM => 14,
                                  AES_EXTENDED => 64, AES_NAES => 65, AES_VERSION => 96, AES_WF_OPTS => 97,
                                  AES_EXTENDED_FUNCTIONS => 98, AES_APPLICATION_OPTIONS => 99,
                                  AES_WINX => 22360, AES_XAAES => 22528);

   function Get_Info(Application_Get_What : Application_Info_Type;
                                 Ap_Out1, Ap_Out2, Ap_Out3, Ap_Out4 : Int16) return Int16;
   
end Gem_AES.Application;
