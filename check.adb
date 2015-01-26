with ada.text_io, ada.integer_text_io;
use  ada.text_io, ada.integer_text_io;
package body check is

   numberPassed     : Natural := 0;
   numberFailed     : Natural := 0;
   numberExceptions : Natural := 0;

   procedure matchg(s, t: ItemType; x: String) is
    -- Compare two ItemType values to see if they are the same
    -- matchg has a name different from other matches to disambiguate in case
    --      ItemType is Integer, Boolean, or String.
   begin
      if  s = t  then
       numberPassed := numberPassed + 1;
      else 
         put("ERROR ----------------" & x);
         put(" - HAVE: "); put(s);
         put("; NEED: "); put(t);
         new_line;
         numberFailed := numberFailed+1;
      end if;
   end matchg;

   procedure match (s: string; t: string; x: String) is
   begin
      if  s = t  then
         numberPassed := numberPassed + 1;
      else 
         put("ERROR ----------------" & x);
         put(" - HAVE: " & s);
         put("; NEED: " & t);
         new_line;
         numberFailed := numberFailed+1;
      end if;
   end match;

   procedure match(s: Integer; t: Integer; x: String) is
   begin
      if  s = t  then
       numberPassed := numberPassed + 1;
      else 
         put("ERROR ----------------" & x);
         put(" - HAVE: " & integer'image(s));
         put("; NEED: " & integer'image(t));
         new_line;
         numberFailed := numberFailed+1;
      end if;
   end match;

   procedure match (s: boolean; t: boolean; x: String) is
   begin
      if  s = t  then
          numberPassed := numberPassed + 1;
      else 
         put("ERROR ----------------" & x);
         put(" - Have: " &boolean'image(s));
         put("; Need: " &boolean'image(t));
         new_line;
         numberFailed := numberFailed+1;
      end if;
   end match;

   procedure clearCounts is 
   begin
         numberPassed := 0;
         numberFailed := 0; 
         numberExceptions := 0; 
   end clearCounts;

   procedure countException is 
   begin
       numberExceptions := numberExceptions + 1;
   end countException;

   procedure showCounts is 
   begin
         put("Number Passed: " & integer'image(numberPassed)); new_line;
         put("Number Failed: " & integer'image(numberFailed)); new_line;
         put("Number Exceps: " & integer'image(numberExceptions)); new_line;
   end showCounts;
end check;
