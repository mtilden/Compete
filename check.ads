generic
    type ItemType is private;
    with function "="(left,right: ItemType)  return boolean is <>;
    -- For comparing two Itemtype values.  <> allows default function if it exists.
    with procedure put(left: ItemType) is <>;
    -- For printing an Itemtype.  <> allows default procedure if it exists.
package check is

   procedure matchg(s: ItemType; t: ItemType; x: String);

   procedure match (s: boolean; t: boolean; x: String);
   procedure match(s: Integer; t: Integer; x: String);
   procedure match (s: string; t: string; x: String);

   procedure clearCounts;
   procedure countException;
   procedure showCounts;
end check;
