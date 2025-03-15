with Ada.Characters.Conversions;
with Ada.Strings.UTF_Encoding.Wide_Wide_Strings;

with Texts.Containers;

with Umwi;

package body Texts is

   use Ada.Strings.Wide_Wide_Unbounded;

   ---------
   -- "<" --
   ---------

   function "<" (L, R : Text) return Boolean is
   begin
      return L.Str < R. Str;
   end "<";

   -------------
   -- To_Text --
   -------------

   function To_Text (This : Wide_Wide_String) return Text
   is (Str => To_Unbounded_Wide_Wide_String (This));

   ------------------
   -- From_Latin_1 --
   ------------------

   function From_Latin_1 (This : Latin_1_String) return Text
   is (To_Text (Ada.Characters.Conversions.To_Wide_Wide_String (This)));

   ----------------
   -- From_UTF_8 --
   ----------------

   function From_UTF_8 (This : UTF_8_String) return Text
   is (To_Text (Ada.Strings.UTF_Encoding.Wide_Wide_Strings.Decode (This)));

   ------------
   -- Decode --
   ------------

   function Decode (This : String; Encoding : Encodings) return Text
   is (case Encoding is
          when Latin_1 => From_Latin_1 (This),
          when UTF_8   => From_UTF_8 (This));

   ------------
   -- Decode --
   ------------

   function Decode (This : Text) return Wide_Wide_String
   is (To_Wide_Wide_String (This.Str));

   ------------
   -- Encode --
   ------------

   function Encode (This : Text; Encoding : Encodings := UTF_8) return String
   is (case Encoding is
          when Latin_1 => This.To_Latin_1,
          when UTF_8   => This.To_UTF_8);

   ----------------
   -- To_Latin_1 --
   ----------------

   function To_Latin_1 (This : Text) return Latin_1_String
   is (Ada.Characters.Conversions.To_String (This.Decode));

   --------------
   -- To_UTF_8 --
   --------------

   function To_UTF_8 (This : Text) return UTF_8_String
   is (Ada.Strings.UTF_Encoding.Wide_Wide_Strings.Encode (This.Decode));

   ------------
   -- Length --
   ------------

   function Length (This : Text) return Natural
   is (Umwi.Count (This.Decode).Clusters);
   --  The length in humanly-recognizable glyphs (unicode grapheme clusters).
   --  NOTE that this is not the equivalent to 'Length.

   ------------
   -- Points --
   ------------

   function Points (This : Text) return Natural
   is (Umwi.Count (This.Decode).Points);
   --  Equivalent to 'Length, so not necessarily humanly-meaningful. The
   --  traditional length of strings seen as raw arrays.

   -----------
   -- Width --
   -----------

   function Width (This : Text) return Natural
   is (Umwi.Count (This.Decode).Width);

   -----------
   -- Split --
   -----------

   function Split (This      : Text;
                   Separator : Code_Point)
                   return Containers.Vector
   is
      S : constant WWString := This.Decode;
      Prev : Integer := S'First - 1;
   begin
      if This.Str = "" then
         return (Containers.Suite.Vecs.Empty_Vector with null record);
      end if;

      return V : Containers.Vector do
         for I in S'Range loop
            if S (I) = Separator then
               V.Append (To_Text (S (Prev + 1 .. I - 1)));
               Prev := I;
            end if;
         end loop;
         V.Append (To_Text (S (Prev + 1 .. S'Last)));
      end return;
   end Split;

end Texts;
