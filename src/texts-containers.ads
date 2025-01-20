with Ada.Containers.Vectors;

package Texts.Containers with Preelaborate is

   package Vectors is new Ada.Containers.Vectors (Positive, Text);

   type Vector is new Vectors.Vector with null record;

end Texts.Containers;
