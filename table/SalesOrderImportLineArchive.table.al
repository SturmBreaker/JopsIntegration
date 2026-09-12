namespace Jops.Trial;

table 50109 "SO Import Line Archive"
{
    Caption = 'Sales Order Import Line Archive';

    fields
    {
        field(1; "Entry No."; Integer) { }
        field(2; "Header Entry No."; Integer)
        {
            TableRelation = "SO Import Header Archive"."Entry No.";
        }
        field(3; "Line No."; Integer) { }
        field(4; "External Line No."; Code[50]) { }
        field(5; "Item No."; Code[20]) { }
        field(6; Description; Text[100]) { }
        field(7; Quantity; Decimal) { }
        field(8; "Unit Price"; Decimal) { }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(HeaderLine; "Header Entry No.", "Line No.") { }
    }
}