table 50115 "PO Import Header"
{
    Caption = 'Purchase Order Import Header';

    fields
    {
        field(1; "Entry No."; Integer) { AutoIncrement = true; Editable = false; }
        field(2; "External Document No."; Code[50]) { }
        field(3; "Vendor No."; Code[20]) { }
        field(4; "Order Date"; Date) { }
        field(5; "Currency Code"; Code[10]) { }
        field(6; Status; Option) { OptionMembers = Pending,Processed,Error; }
        field(7; "Error Message"; Text[250]) { }
        field(8; "Received At"; DateTime) { }
        field(9; "Purchase Order No."; Code[20]) { }
        field(10; "Webhook Status"; Option) { OptionMembers = Pending,Sent,Error; }
        field(11; "Webhook Error Message"; Text[250]) { }
        field(12; "Receipt No."; Code[20]) { }
        field(13; "Invoice No."; Code[20]) { }
        field(14; "Vendor Shipment No."; Code[35]) { }
        field(15; "Vendor Invoice No."; Code[35]) { }
    }

    keys
    {
        key(PK; "Entry No.") { Clustered = true; }
        key(ExternalDocument; "External Document No.") { }
    }

    trigger OnDelete()
    var
        POImportLine: Record "PO Import Line";
    begin
        // if Status = Status::Processed then
        //     Error(CannotDeleteProcessedErr, "External Document No.");

        POImportLine.SetRange("Header Entry No.", "Entry No.");
        POImportLine.DeleteAll(true);
    end;

    var
        CannotDeleteProcessedErr: Label 'Cannot delete PO Import Header %1 because it has already been processed.', Comment = '%1 = External Document No.';
}