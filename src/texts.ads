private with Ada.Strings.Wide_Wide_Unbounded;

limited with Texts.Containers;

package Texts with Preelaborate is

   --  A minimalistic library to deal with human texts while providing
   --  the basic functionality of a string type. Biased towards Alire
   --  needs, so features will be haphazard. The main goal is to make
   --  Wide_Wide_Unbounded_String a bit more comfortable, while remaining
   --  compatible with Ada 2012, and also staying safely within Unicode.
   --
   --  Much more powerful libraries exist (e.g., vss, uxstrings), but they
   --  either require Ada 2022, a compiler newer than those used to build
   --  Alire, or bring in too much extra baggage. It is conceivable that as
   --  Alire leaves behind those restrictions with time, this library just
   --  acts as a wrapper over those fancier alternatives.

   type Encodings is
     (Latin_1,
      --  The native encoding of Ada strings. In conformant mode, or for
      --  Alire projects with default settings, String literals will have this
      --  encoding (not UTF-8, even if the source files are UTF-8-encoded!).
      --  NOTE that strings read with Ada.Text_IO will be also Latin-1-encoded.

      UTF_8
      --  The usual encoding everywhere nowadays. OS-provided strings in any
      --  sane modern system will have this encoding. Note that Ada.Text_IO
      --  will return Latin-1-encoded strings.
     );

   type Text is tagged private;
   --  A Unicode text. Internal representation is deliberately private.

   function "<" (L, R : Text) return Boolean;
   --  Based on code points, subject to change

   --  Subtypes for documentation; they do not imply any actual checks
   subtype Latin_1_String is String;
   subtype UTF_8_String is String;

   -----------------------
   --  Boxing/Unboxing  --
   -----------------------

   function To_Text (This : Wide_Wide_String) return Text;

   function From_Latin_1 (This : Latin_1_String) return Text;
   function From_UTF_8 (This : UTF_8_String) return Text;

   function Decode (This : String; Encoding : Encodings) return Text;
   function Decode (This : Text) return Wide_Wide_String;
   --  Unwrap to a plain Ada string

   function Encode (This : Text; Encoding : Encodings := UTF_8) return String;

   function To_Latin_1 (This : Text) return Latin_1_String;
   function To_UTF_8 (This : Text) return UTF_8_String;

   ------------------------
   --  Basic properties  --
   ------------------------

   function Length (This : Text) return Natural;
   --  The length in humanly-recognizable glyphs (unicode grapheme clusters).
   --  NOTE that this is not the equivalent to 'Length.

   function Points (This : Text) return Natural;
   --  Equivalent to 'Length, so not necessarily humanly-meaningful. The
   --  traditional length of strings seen as raw arrays.

   function Width (This : Text) return Natural;
   --  Width in cells of a fixed-width font. That is, how many columns in a
   --  terminal this text should take (in a Unicode-honoring terminal). Given
   --  that emoji combos support is haphazard, there are not many guarantees
   --  here... Use UMWI crate for finer control.

   --------------------------
   --  Basic manipulation  --
   --------------------------

   subtype Code_Point is Wide_Wide_Character;

   function Split (This : Text) return Containers.Vector;
   --  TODO: this is just a test that we can depend on a limited-width child.
   --  Use proper profile for customizable splits.

private

   Unimplemented : exception;

   type Text is tagged record
      Str : Ada.Strings.Wide_Wide_Unbounded.Unbounded_Wide_Wide_String;
   end record;

end Texts;
