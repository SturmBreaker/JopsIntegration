codeunit 50118 "PO Import Processor"
{
    TableNo = "PO Import Header";

    trigger OnRun()
    begin
        ProcessPending();
    end;

    procedure ProcessPending()
    var
        ImportHeader: Record "PO Import Header";
    begin
        ImportHeader.SetRange(Status, ImportHeader.Status::Pending);
        ImportHeader.SetFilter("Receipt No.", '=%1', '');
        ImportHeader.SetFilter("Invoice No.", '=%1', '');
        ProcessHeaders(ImportHeader);
    end;

    procedure ProcessSelected(var ImportHeader: Record "PO Import Header")
    begin
        ImportHeader.SetRange(Status, ImportHeader.Status::Pending);
        ImportHeader.SetFilter("Receipt No.", '=%1', '');
        ImportHeader.SetFilter("Invoice No.", '=%1', '');
        ProcessHeaders(ImportHeader);
    end;

    local procedure ProcessHeaders(var ImportHeader: Record "PO Import Header")
    var
        SetupMgt: Codeunit "Order Integration Setup Mgt.";
        OrderCreated: Boolean;
    begin
        if not ImportHeader.FindSet() then
            exit;

        repeat
            if ImportHeader."Purchase Order No." = '' then
                OrderCreated := Codeunit.Run(Codeunit::"PO Import Worker", ImportHeader);

            if OrderCreated or (ImportHeader."Purchase Order No." <> '') then begin
                if SetupMgt.IsPurchasePostingEnabled() then
                    PostPurchaseOrder(ImportHeader)
                else begin
                    ImportHeader.Status := ImportHeader.Status::Processed;
                    ImportHeader."Error Message" := '';
                end;
            end else begin
                ImportHeader.Status := ImportHeader.Status::Error;
                ImportHeader."Error Message" := CopyStr(GetLastErrorText(), 1, MaxStrLen(ImportHeader."Error Message"));
            end;
            ImportHeader.Modify(true);

            if SetupMgt.IsPurchaseWebhookEnabled() then begin
                if Codeunit.Run(Codeunit::"PO Import Webhook", ImportHeader) then begin
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

    local procedure PostPurchaseOrder(var ImportHeader: Record "PO Import Header")
    var
        PurchaseHeader: Record "Purchase Header";
        PurchReceiptHeader: Record "Purch. Rcpt. Header";
        PurchInvoiceHeader: Record "Purch. Inv. Header";
    begin
        if ImportHeader."Purchase Order No." = '' then
            exit;

        PurchaseHeader.Get(PurchaseHeader."Document Type"::Order, ImportHeader."Purchase Order No.");
        if not Codeunit.Run(Codeunit::"Purch.-Post", PurchaseHeader) then begin
            ImportHeader.Status := ImportHeader.Status::Error;
            ImportHeader."Error Message" := CopyStr(GetLastErrorText(), 1, MaxStrLen(ImportHeader."Error Message"));
        end else begin
            ImportHeader.Status := ImportHeader.Status::Processed;
            ImportHeader."Error Message" := '';
            PurchReceiptHeader.SetRange("Order No.", ImportHeader."Purchase Order No.");
            PurchReceiptHeader.FindLast();
            ImportHeader."Receipt No." := PurchReceiptHeader."No.";
            PurchInvoiceHeader.SetRange("Order No.", ImportHeader."Purchase Order No.");
            PurchInvoiceHeader.FindLast();
            ImportHeader."Invoice No." := PurchInvoiceHeader."No.";
        end;
        ImportHeader.Modify(true);
    end;
}