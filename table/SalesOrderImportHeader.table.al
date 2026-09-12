namespace Jops.Trial;

table 50101 "SO Import Header"
{
    Caption = 'Sales Order Import Header';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "External Document No."; Code[50]) { }
        field(3; "Customer No."; Code[20]) { }
        field(4; "Order Date"; Date) { }
        field(5; "Currency Code"; Code[10]) { }
        field(6; Status; Option)
        {
            OptionMembers = Pending,Processed,Error;
        }
        field(7; "Error Message"; Text[250]) { }
        field(8; "Received At"; DateTime) { }
        field(9; "Sales Order No."; Code[20]) { }
        field(10; "Webhook Status"; Option)
        {
            OptionMembers = Pending,Sent,Error;
        }
        field(11; "Webhook Error Message"; Text[250]) { }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(ExternalDocument; "External Document No.") { }
    }
}