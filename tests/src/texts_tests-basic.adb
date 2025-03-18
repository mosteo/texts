procedure Texts_Tests.Basic is
   A_Tilde : constant Text := +"á";
   E_Tilde : constant Text := +(Code_Point'Val (16#65#)
                                & Code_Point'Val (16#301#));
   Wide : constant Text := +"🎵";
begin
   Assert (+"a" = "a");
   Assert (+"a" /= "b");
   Assert (+"a" < +"b");

   Assert (A_Tilde.Length = 1);
   Assert (A_Tilde.Points = 1);
   Assert (A_Tilde.Width = 1);

   Assert (E_Tilde.Length = 1);
   Assert (E_Tilde.Points = 2);
   Assert (E_Tilde.Width = 1);

   Assert (Wide.Length = 1);
   Assert (Wide.Points = 1);
   Assert (Wide.Width = 2);
end Texts_Tests.Basic;
