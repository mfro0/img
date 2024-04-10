package GEM.AES.Object is

   type UInt8 is mod 8;
   type Bit is mod 1;

   Root              : constant UInt16 := 0;
   type Bf_Ob_Spec is record
      Char           : UInt8; 
      Frame_Size     : UInt8;
      Frame_Col      : UInt8;
      Text_Col       : UInt8;
      Text_Mode      : Bit;
      Fill_Pattern   : UInt8;
      Interior_Color : UInt8;
   end record;
   for Bf_Ob_Spec use record
      Char           at 0 range 24 .. 31;
      Frame_Size     at 0 range 16 .. 23;
      Frame_Col      at 0 range 12 .. 15;
      Text_Col       at 0 range 8 .. 11;
      Text_Mode      at 0 range 7 .. 7;
      Fill_Pattern   at 0 range 4 .. 6;
      Interior_Color at 0 range 0 .. 3;
   end record;

   type String_Ptr is access String;
   type Text_Ed_Info is record
      Te_Ptext       : String_Ptr;
      Te_Ptmplt      : String_Ptr;
      Te_PValid      : String_Ptr;
      Te_Font        : UInt16;
      Te_Font_Id     : UInt16;
      Te_Just        : UInt16;
      Te_Color       : UInt16;
      Te_Fontsize    : UInt16;
      Te_Thickness   : UInt16;
      Te_Txtlen      : UInt16;
      Te_Tmplen      : UInt16;
   end record;
   type Te_Info_Ptr is access Text_Ed_Info;

   type Bit_Block is record
      Bi_PData       : String_Ptr;
      Bi_Wb          : UInt16;
      Bi_Hl          : UInt16;
      Bi_X           : UInt16;
      Bi_Y           : UInt16;
      Bi_Color       : UInt16;
   end record;
   type Bit_Blk_Ptr is access Bit_Block;

   type Int16_Ptr is access Int16;
   type Icn_Blk is record
      Ib_Pmask       : Int16_Ptr;
      Ib_Pdata       : Int16_Ptr;
      Ib_Ptext       : String_Ptr;
      Ib_Char        : Int16;
      Ib_XChar       : Int16;
      Ib_YChar       : Int16;
      Ib_XIcon       : Int16;
      Ib_YIcon       : Int16;
      Ib_Wicon       : Int16;
      Ib_Hicon       : Int16;
      Ib_XText       : Int16;
      Ib_YText       : Int16;
      Ib_WText       : Int16;
      Ib_HText       : Int16;
   end record;
   type Icn_Blk_Ptr is access Icn_Blk;

   type Ob_Spec_Ptr;
   type Ob_Spec_Ptr_Ptr is access Ob_Spec_Ptr;

   type Selector is (Index, Indirect, Bitfield_Ob_Spec, Ted_Info, Bitblock, Icn_Block);
   type Ob_Spec_Ptr(Sel : Selector := Index) is record
      case Sel is
         when Index              => Index       : Long_Integer;
         when Indirect           => Indirect    : Access Ob_Spec_Ptr_Ptr;
         when Bitfield_Ob_Spec   => Ob_Spec     : Bf_Ob_Spec;
         when Ted_Info           => Ted_Info    : Te_Info_Ptr;
         when Bitblock           => Bit_Blk     : Bit_Blk_Ptr;
         when Icn_Block          => Icn_Blk     : Icn_Blk_Ptr;
      end case;
   end record;

   type Resource_Object is record
      Ob_Next     : Int16;
      Ob_Head     : Int16;
      Ob_Tail     : Int16;
      Ob_Type     : Int16;
      Ob_Flags    : Int16;
      Ob_State    : Int16;
      Ob_Spec     : Ob_Spec_Ptr;
      Ob_X,
      Ob_Y,
      Ob_Width,
      Ob_Height   : Int16;
   end record;
   pragma Pack(Resource_Object);

   type Resource_Array is array(natural range <>) of Resource_Object;
end GEM.AES.Object;
