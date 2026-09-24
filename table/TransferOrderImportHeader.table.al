table 50132 "TO Import Header"
{
    Caption = 'Transfer Order Import Header';

    fields
    {
        field(1; "Entry No."; Integer) { AutoIncrement = true; Editable = false; }
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
        field(12; "Shipment No."; Code[20])
        {
            TableRelation = "Transfer Shipment Header"."No.";
            ValidateTableRelation = false;
        }
        field(13; "Receipt No."; Code[20])
        {
            TableRelation = "Transfer Receipt Header"."No.";
            ValidateTableRelation = false;
        }
    }

    keys
    {
        key(PK; "Entry No.") { Clustered = true; }
        key(ExternalDocument; "External Document No.") { }
    }

    trigger OnDelete()
    var
        TOImportLine: Record "TO Import Line";
    begin
        // if Status = Status::Processed then
        //     Error(CannotDeleteProcessedErr, "External Document No.");

        TOImportLine.SetRange("Header Entry No.", "Entry No.");
        TOImportLine.DeleteAll(true);
    end;

    var
        CannotDeleteProcessedErr: Label 'Cannot delete TO Import Header %1 because it has already been processed.', Comment = '%1 = External Document No.';
}