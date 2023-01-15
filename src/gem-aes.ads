with Interfaces.C;
with System;

package GEM.AES is
   type Int16 is new integer range -2 ** 16 .. 2 ** 16 - 1;
   type Uint16 is new Interfaces.Unsigned_16;
   type Uint16_Array_Type is array(integer range <>) of Uint16;
   type Address_Array_Type is array(integer range <>) of System.Address;

   type Aes_Pb_Type is record
      P_Control,
      P_Global,
      P_Int_In,
      P_Int_Out     : System.Address;
      P_Addr_In,
      P_Addr_Out    : System.Address;
   end record;

   type Rectangle is record
      X, Y, W, H     : Int16;
   end record;

   Cntrl            : Uint16_Array_Type(0 .. 4);
   Global           : Uint16_Array_Type(0 .. 14);
   Int_In           : Uint16_Array_Type(0.. 15);
   Int_Out          : Uint16_Array_Type(0 .. 9) := (others => 0);

   Addr_In          : Address_Array_Type(0 .. 7);
   Addr_Out         : Address_Array_Type(0 .. 1);

   Aes_Pb : Aes_Pb_Type := Aes_Pb_Type'(Cntrl'Address, Global'Address,
                                        Int_In'Address, Int_Out'Address,
                                        Addr_In'Address, Addr_Out'Address);
end; 