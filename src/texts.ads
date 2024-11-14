private with Ada.Strings.Wide_Wide_Unbounded;

package Texts with Preelaborate is

   type Text is tagged private;
   --  A Unicode text

private

   type Text is tagged record
      Str : Ada.Strings.Wide_Wide_Unbounded.Unbounded_Wide_Wide_String;
   end record;

end Texts;
