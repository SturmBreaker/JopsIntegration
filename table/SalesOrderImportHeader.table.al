table 50101 "SO Import Header"
{
    Caption = 'Sales Order Import Header';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Editable = false;
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
        field(12; "Shipment No."; Code[20])
        {
            TableRelation = "Sales Shipment Header"."No.";
            ValidateTableRelation = false;
        }
        field(13; "Invoice No."; Code[20])
        {
            TableRelation = "Sales Invoice Header"."No.";
            ValidateTableRelation = false;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(ExternalDocument; "External Document No.") { }
    }

    trigger OnDelete()
    var
        SOImportLine: Record "SO Import Line";
    begin
        // if Status = Status::Processed then
        //     Error(CannotDeleteProcessedErr, "External Document No.");

        SOImportLine.SetRange("Header Entry No.", "Entry No.");
        SOImportLine.DeleteAll(true);
    end;

    var
        CannotDeleteProcessedErr: Label 'Cannot delete SO Import Header %1 because it has already been processed.', Comment = '%1 = External Document No.';
}