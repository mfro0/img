with GEM.AES; use GEM.AES;

package GEM.AES.Resource is
   type Resource_Type is (Tree,                -- R_TREE
                          Object,              -- R_OBJECT
                          Text_Ed_Info,        -- R_TEDINFO
                          Icon_Block,          -- R_ICONBLK
                          Bit_Block,           -- R_BITBLK
                          R_String,            -- R_STRING
                          Image_Data,          -- R_IMAGEDATA
                          Object_Spec,         -- R_OBSPEC
                          Text_Pointer,        -- R_TEPTEXT
                          Template_Pointer,    -- R_TEPTMPLT
                          Valid_Pointer,       -- R_TEPVALID
                          Icon_Mask_Pointer,   -- R_IBPMASK
                          Icon_Data_Pointer,   -- R_IBPDATA
                          Icon_Text_Pointer,   -- R_IBPTEXT
                          Bitmap_Data_Pointer, -- R_BIPDATA
                          Free_String,         -- R_FRSTR
                          Free_Image           -- R_FRIMG
                         );
   for Resource_Type use (Tree => 0,
                          Object => 1,
                          Text_Ed_Info => 2,
                          Icon_Block => 3,
                          Bit_Block => 4,
                          R_String => 5,
                          Image_Data => 6,
                          Object_Spec => 7,
                          Text_Pointer => 8,
                          Template_Pointer => 9,
                          Valid_Pointer => 10,
                          Icon_Mask_Pointer => 11,
                          Icon_Data_Pointer => 12,
                          Icon_Text_Pointer => 13,
                          Bitmap_Data_Pointer => 14,
                          Free_String => 15,
                          Free_Image => 16
                         );
   function Get_Address(Typ : Resource_Type; Index : Int16; Addr : out System.Address) return Int16;
   function Free return Int16;
   function Load(Resource_Name : String) return Int16;
end GEM.AES.Resource;
