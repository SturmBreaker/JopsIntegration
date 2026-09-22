table 50116 "PO Import Line"
{
    Caption = 'Purchase Order Import Line';

    fields
    {
        field(1; "Entry No."; Integer) { AutoIncrement = true; Editable = false; }
        field(2; "Header Entry No."; Integer)
        {
            TableRelation = "PO Import Header"."Entry No.";
        }
        field(3; "Line No."; Integer) { }
        field(4; "External Line No."; Code[50]) { }
        field(5; "Item No."; Code[20]) { }
        field(6; Description; Text[100]) { }
        field(7; Quantity; Decimal) { }
        field(8; "Unit Cost"; Decimal) { }
    }

    keys
    {
        key(PK; "Entry No.") { Clustered = true; }
        key(HeaderLine; "Header Entry No.", "Line No.") { }
    }
}