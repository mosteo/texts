with Ada.Containers.Vectors;

with AAA.Containers.Suite;

package Texts.Containers with Preelaborate is

   package Vectors is new Ada.Containers.Vectors (Positive, Text);

   package Suite is new AAA.Containers.Suite (Text, Text);

   type Map    is new Suite.Maps.Map with null record;
   type Set    is new Suite.Sets.Set with null record;
   type Vector is new Suite.Vecs.Vector with null record;

end Texts.Containers;
