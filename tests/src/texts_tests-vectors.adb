procedure Texts_Tests.Vectors is
   use Containers;
   V  : constant Containers.Vector := Split ("asdf qwer", ' ');
   L3 : constant Containers.Vector := Split ("asdf qwer zxcv", ' ');
begin
   Assert (V.First_Element = "asdf");
   Assert (V.Last_Element = "qwer");

   Assert (Split ("", ' ').Length in 1);
   Assert (Split ("", ' ').First_Element = "");
   Assert (Split (" ", ' ').Length in 2);

   Assert (L3 (1) = "asdf");
   Assert (L3 (2) = "qwer");
   Assert (L3 (3) = "zxcv");
end Texts_Tests.Vectors;
