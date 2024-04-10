with System;
with System.Machine_Code; use System.Machine_Code;
with Interfaces; use Interfaces;
with Interfaces.C.Strings;
with Ada.Unchecked_Conversion;
with Ada.Text_IO; use Ada.Text_IO;

package body GEM.AES.Application is
   function To_Address is new Ada.Unchecked_Conversion(System.Address, Unsigned_32);
   function To_App_Id is new Ada.Unchecked_Conversion(Uint16, App_Id_Type);
   
   function Init return App_Id_Type is
      use ASCII;
      pragma Inline(Init);
   begin
      Cntrl := (0 => 10, 2 => 1, others => 0);
      Asm("move.l       %0,%%d1"        & LF & HT &
          "move.w       #200,%%d0"      & LF & HT &
          "trap         #2"             & LF & HT,
          Volatile => True,
          Inputs => Interfaces.Unsigned_32'Asm_Input("g", To_Address(Aes_Pb'Address)), 
          Clobber => "d0,d1,a0,a1"
      );
      return To_App_Id(Int_Out(0));
   end Init;

   -- inconsistent naming to avoid clash with keyword 
   procedure AExit is
      use ASCII;
      pragma Inline(AExit);
   begin
      Cntrl := (0 => 19, 2 => 1, others => 0);
      Asm("move.l    %0,%%d1"           & LF & HT &
          "move.w    #200,%%d0"         & LF & HT &
          "trap      #2"                & LF & HT,
          Volatile => True, 
          Inputs => Interfaces.Unsigned_32'Asm_Input("g", To_Address(Aes_Pb'Address)), 
          Clobber => "d0,d1,a0,a1"
      );

      if Int_Out(0) = 0 then
         raise AES_Exception with "failed to cleanly exit the AES Application (" & Interfaces.Unsigned_16'image(Int_Out(0)) & ")";
      end if;
   end AExit;

   procedure Bitvector_Set(Floppy_Disk_Vector : Uint16; Hard_Disk_Vector : Uint16) is
      use ASCII;
      pragma Inline(Bitvector_Set);
   begin
      Cntrl := (0 => 16, 1 => 2, 2 => 1, others => 0);
      Int_In(0) := Floppy_Disk_Vector;
      Int_In(1) := Hard_Disk_Vector;
      Asm("move.l       %0,%%d1"        & LF & HT &
          "move.w       #200,%%d0"      & LF & HT &
          "trap         #2"             & LF & HT,
          Volatile => True, 
          Inputs => Interfaces.Unsigned_32'Asm_Input("g", To_Address(Aes_Pb'Address)), 
          Clobber => "d0,d1,a0,a1"
      );
   end Bitvector_Set;

   function Control(Application_ID : in Int16; C : in Control_Type; ControlOut : out Int16) return Int16 is
      use ASCII;
      pragma Inline(Control);
   begin
      -- Enum_Rep is an Ada 2022 feature
      Cntrl := (0 => 129, 1 => 1, 3 => 1, others => 0);
      Int_In(0) := Control_Type'Enum_Rep(C);
      Asm("move.l       %0,%%d1"        & LF & HT &
          "move.w       #200,%%d0"      & LF & HT &
          "trap         #2"             & LF & HT,
          Volatile => True, 
          Inputs => Interfaces.Unsigned_32'Asm_Input("g", To_Address(Aes_Pb'Address)), 
          Clobber => "d0,d1,a0,a1"
      );
      ControlOut := Int16(Int_Out(1));
      return Int16(Int_Out(0));
   end Control;

   function Find(Application_Name : String) return Int16 is
      use ASCII;
      pragma Inline(Find);
      C_Name : String := Application_Name & NUL;
   begin
      Cntrl := (0 => 13, 1 => 0, 2 => 1, 3 => 1, 4 => 0);
      Addr_In(0) := C_Name'Address;
      Asm("move.l       %0,%%d1"         & LF & HT &
          "move.w       #200,%%d0"       & LF & HT &
          "trap         #2"            & LF & HT, 
          Volatile => True,
          Inputs => Interfaces.Unsigned_32'Asm_Input("g", To_Address(Aes_Pb'Address)), 
          Clobber => "d0,d1,a0,a1"
      );
      return Int16(Int_Out(0));
   end Find;

   function Get_Info(Application_Get_What : Application_Info_Type;
                     Ap_Out1, Ap_Out2, Ap_Out3, Ap_Out4 : out Int16) return Int16 is
      use ASCII;
   begin
      Cntrl := (0 => 130, 1 => 1, 2 => 5, others => 0);
      Int_In(0) := Application_Info_Type'Enum_Rep(Application_Get_What);
      Asm("move.l       %0,%%d1"         & LF & HT &
          "move.w       #200,%%d0"       & LF & HT &
          "trap         #2"            & LF & HT, 
          Volatile => True,
          Inputs => Interfaces.Unsigned_32'Asm_Input("g", To_Address(Aes_Pb'Address)), 
          Clobber => "d0,d1,a0,a1"
      );
      Ap_Out1 := Int16(Int_Out(1));
      Ap_Out2 := Int16(Int_Out(2));
      Ap_Out3 := Int16(Int_Out(3));
      Ap_Out4 := Int16(Int_Out(4));
      return Int16(Int_Out(0));
   end Get_Info;

   function Read(Application_Id : Int16; Read_Length : Int16; Buff : out Uint16_Array_Type) return Int16 is
      use ASCII;

      Buffer   : Uint16_Array_Type(1 .. Integer(Read_Length));
   begin
      Cntrl := (0 => 11, 1 => 2, 2 => 1, 3 => 1, others => 0);
      Int_In := (0 => Uint16(Application_Id), 1 => Uint16(Read_Length), others => 0);
      Addr_In(0) := Buffer'Address;
      Asm("move.l       %0,%%d1"         & LF & HT &
          "move.w       #200,%%d0"       & LF & HT &
          "trap         #2"            & LF & HT, 
          Volatile => True,
          Inputs => Interfaces.Unsigned_32'Asm_Input("g", To_Address(Aes_Pb'Address)), 
          Clobber => "d0,d1,a0,a1"
      );
      Buff := Buffer;
      return Int16(Int_Out(0));
   end Read;

   function Search(Search_Mode : Int16; Name : String; Application_Type, Application_Id : out Int16) return Int16 is
      use ASCII;
   begin
      Cntrl := (0 => 18, 1 => 1, 2 => 3, 3 => 1, others => 0);
      Int_In := (0 => Uint16(Search_Mode), others => 0);
      Addr_In(0) := Name'Address;
      Asm("move.l       %0,%%d1"         & LF & HT &
          "move.w       #200,%%d0"       & LF & HT &
          "trap         #2"            & LF & HT, 
          Volatile => True,
          Inputs => Interfaces.Unsigned_32'Asm_Input("g", To_Address(Aes_Pb'Address)), 
          Clobber => "d0,d1,a0,a1"
      );
      Application_Type := Int16(Int_Out(1));
      Application_Id := Int16(Int_Out(2));

      return Int16(Int_Out(0));
   end Search;   
end GEM.AES.Application;
