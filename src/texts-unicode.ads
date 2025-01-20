package Texts.Unicode with Preelaborate is

   subtype Code_Point is Wide_Wide_Character;

   --  Note that the following types are used to disambiguate expectations, but
   --  there is no checking that the actually stored byte sequence is properly
   --  encoded.

   subtype UTF_8_String  is String;
   subtype UTF_16_String is Wide_String;
   subtype UTF_32_String is Wide_Wide_String;

end Texts.Unicode;
