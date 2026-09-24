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
        SetupMgt: Codeunit "Order Integration Setup Mgt.";
        OrderCreated: Boolean;
    begin
        if not ImportHeader.FindSet() then
            exit;

        repeat
            if ImportHeader."Sales Order No." = '' then
                OrderCreated := Codeunit.Run(Codeunit::"SO Import Worker", ImportHeader);

            if OrderCreated or (ImportHeader."Sales Order No." <> '') then begin
                if SetupMgt.IsSalesPostingEnabled() then
                    postSalesOrder(ImportHeader)
            end else begin
                ImportHeader.Status := ImportHeader.Status::Error;
                ImportHeader."Error Message" := CopyStr(GetLastErrorText(), 1, MaxStrLen(ImportHeader."Error Message"));
            end;

            ImportHeader."Webhook Status" := ImportHeader."Webhook Status"::Pending;
            ImportHeader."Webhook Error Message" := '';
            ImportHeader.Modify(true);

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

    local procedure PostSalesOrder(var ImportHeader: Record "SO Import Header")
    var
        SalesHeader: Record "Sales Header";
        SalesShipmentHeader: Record "Sales Shipment Header";
        SalesInvoiceHeader: Record "Sales Invoice Header";
    begin
        if importHeader."Sales Order No." = '' then
            exit;

        SalesHeader.Get(SalesHeader."Document Type"::Order, ImportHeader."Sales Order No.");
        if not Codeunit.Run(Codeunit::"Sales-Post", SalesHeader) then begin
            ImportHeader.Status := ImportHeader.Status::Error;
            ImportHeader."Error Message" := CopyStr(GetLastErrorText(), 1, MaxStrLen(ImportHeader."Error Message"));
        end else begin
            ImportHeader.Status := ImportHeader.Status::Processed;
            ImportHeader."Error Message" := '';
            SalesShipmentHeader.SetRange("Order No.", ImportHeader."Sales Order No.");
            SalesShipmentHeader.FindLast();
            ImportHeader."Shipment No." := SalesShipmentHeader."No.";
            SalesInvoiceHeader.SetRange("Order No.", ImportHeader."Sales Order No.");
            SalesInvoiceHeader.FindLast();
            ImportHeader."Invoice No." := SalesInvoiceHeader."No.";
        end;
        ImportHeader.Modify(true);

    end;
}