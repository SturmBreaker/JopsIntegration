namespace Jops.Trial;

table 50138 "TO Import Header Archive"
{
    Caption = 'Transfer Order Import Header Archive';

    fields
    {
        field(1; "Entry No."; Integer) { }
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
        field(12; "Archived At"; DateTime) { }
    }

    keys
    {
        key(PK; "Entry No.") { Clustered = true; }
        key(ExternalDocument; "External Document No.") { }
    }
}