pragma Warnings (Off);
with Ada.Assertions; use Ada.Assertions;
with Texts; use Texts;
with Texts.Containers;
pragma Warnings (On);

package Texts_Tests is

   function "+" (S : Wide_Wide_String) return Text renames To_Text;

end Texts_Tests;
