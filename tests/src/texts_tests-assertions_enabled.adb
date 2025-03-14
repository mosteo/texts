procedure Texts_Tests.Assertions_Enabled is
begin
   pragma Assert (False);
   raise Program_Error;
exception
   when others =>
      null;
end Texts_Tests.Assertions_Enabled;
