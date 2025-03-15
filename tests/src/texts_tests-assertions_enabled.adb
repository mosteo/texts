procedure Texts_Tests.Assertions_Enabled is
begin
   begin
      pragma Assert (False);
   exception
      when others =>
         return;
   end;
   raise Program_Error with "should have raised";
end Texts_Tests.Assertions_Enabled;
