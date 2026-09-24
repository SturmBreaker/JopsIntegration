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
    begin
        if not ImportHeader.FindSet() then
            exit;

        repeat
            if ImportHeader."Sales Order No." = '' then begin
                if Codeunit.Run(Codeunit::"SO Import Worker", ImportHeader) then begin
                    SalesShipmentHeader.SetRange("Order No.", ImportHeader."Sales Order No.");
                    SalesShipmentHeader.FindLast();
                    ImportHeader."Shipment No." := SalesShipmentHeader."No.";
                    SalesInvoiceHeader.SetRange("Order No.", ImportHeader."Sales Order No.");
                    SalesInvoiceHeader.FindLast();
                    ImportHeader."Invoice No." := SalesInvoiceHeader."No.";
                    ImportHeader.Status := ImportHeader.Status::Processed;
                    ImportHeader."Error Message" := '';
                end else begin
                    ImportHeader.Status := ImportHeader.Status::Error;
                    ImportHeader."Error Message" := CopyStr(GetLastErrorText(), 1, MaxStrLen(ImportHeader."Error Message"));
                end;
                ImportHeader.Modify(true);
            end;

            if SetupMgt.IsSalesWebhookEnabled() then begin
                if Codeunit.Run(Codeunit::"SO Import Webhook", ImportHeader) then begin
                    ImportHeader."Webhook Status" := ImportHeader."Webhook Status"::Sent;
                    ImportHeader."Webhook Error Message" := '';
                end else begin
                    ImportHeader."Webhook Status" := ImportHeader."Webhook Status"::Error;
                    ImportHeader."Webhook Error Message" := CopyStr(GetLastErrorText(), 1, MaxStrLen(ImportHeader."Webhook Error Message"));
                end;
                ImportHeader.Modify(true);
            end;
            Commit();
        until ImportHeader.Next() = 0;
    end;
}