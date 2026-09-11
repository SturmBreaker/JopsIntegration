namespace Jops.Trial;

table 50132 "Jops TO Import Header"
{
    Caption = 'Transfer Order Import Header';

    fields
    {
        field(1; "Entry No."; Integer) { AutoIncrement = true; }
        field(2; "External Document No."; Code[50]) { }
        field(3; "Transfer-from Code"; Code[10]) { }
        field(4; "Transfer-to Code"; Code[10]) { }
        field(5; "Order Date"; Date) { }
        field(6; Status; Option) { OptionMembers = Pending,Processed,Error; }
        field(7; "Error Message"; Text[250]) { }
        field(8; "Received At"; DateTime) { }
        field(9; "Transfer Order No."; Code[20]) { }
        field(10; "Webhook Status"; Option) { OptionMembers = Pending,Sent,Error; }
        field(11; "Webhook Error Message"; Text[250]) { }
    }

    keys
    {
        key(PK; "Entry No.") { Clustered = true; }
        key(ExternalDocument; "External Document No.") { }
    }
}