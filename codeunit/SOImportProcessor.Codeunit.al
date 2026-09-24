codeunit 50105 "SO Import Processor"
{
    TableNo = "SO Import Header";

    trigger OnRun()
    begin
        ProcessPending();
    end;

    procedure ProcessPending()
    var
        ImportHeader: Record "SO Import Header";
    begin
        ImportHeader.SetRange(Status, ImportHeader.Status::Pending);
        importHeader.SetFilter("Shipment No.", '=%1', '');
        importHeader.SetFilter("Invoice No.", '=%1', '');
        ProcessHeaders(ImportHeader);
    end;

    procedure ProcessSelected(var ImportHeader: Record "SO Import Header")
    begin
        ImportHeader.SetRange(Status, ImportHeader.Status::Pending);
        importHeader.SetFilter("Shipment No.", '=%1', '');
        importHeader.SetFilter("Invoice No.", '=%1', '');
        ProcessHeaders(ImportHeader);
    end;

    local procedure ProcessHeaders(var ImportHeader: Record "SO Import Header")
    var
        SalesShipmentHeader: Record "Sales Shipment Header";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SetupMgt: Codeunit "Order Integration Setup Mgt.";
        ImportHeaderLoc: record "SO Import Header";
    begin
        if not ImportHeader.FindSet() then
            exit;

        repeat
            if ImportHeader."Sales Order No." = '' then begin
                if Codeunit.Run(Codeunit::"SO Import Worker", ImportHeader) then begin
                    SalesShipmentHeader.SetRange("Order No.", ImportHeader."Sales Order No.");
                    SalesShipmentHeader.FindLast();
                    ImportHeaderLoc.Get(ImportHeader."Entry No.");
                    ImportHeaderLoc."Shipment No." := SalesShipmentHeader."No.";
                    SalesInvoiceHeader.SetRange("Order No.", ImportHeaderLoc."Sales Order No.");
                    SalesInvoiceHeader.FindLast();
                    ImportHeaderLoc."Invoice No." := SalesInvoiceHeader."No.";
                    ImportHeaderLoc.Status := ImportHeaderLoc.Status::Processed;
                    ImportHeaderLoc."Error Message" := '';
                end else begin
                    ImportHeaderLoc.Get(ImportHeader."Entry No.");
                    ImportHeaderLoc.Status := ImportHeaderLoc.Status::Error;
                    ImportHeaderLoc."Error Message" := CopyStr(GetLastErrorText(), 1, MaxStrLen(ImportHeaderLoc."Error Message"));
                end;
                ImportHeaderLoc.Modify(true);
            end;

            if SetupMgt.IsSalesWebhookEnabled() then begin
                ImportHeaderLoc.Get(ImportHeader."Entry No.");
                if Codeunit.Run(Codeunit::"SO Import Webhook", ImportHeader) then begin
                    ImportHeaderLoc."Webhook Status" := ImportHeaderLoc."Webhook Status"::Sent;
                    ImportHeaderLoc."Webhook Error Message" := '';
                end else begin
                    ImportHeaderLoc."Webhook Status" := ImportHeaderLoc."Webhook Status"::Error;
                    ImportHeaderLoc."Webhook Error Message" := CopyStr(GetLastErrorText(), 1, MaxStrLen(ImportHeaderLoc."Webhook Error Message"));
                end;
                ImportHeaderLoc.Modify(true);
            end;
            Commit();
        until ImportHeader.Next() = 0;
    end;
}