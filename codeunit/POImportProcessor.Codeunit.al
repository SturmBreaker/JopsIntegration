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
        PurchReceiptHeader: Record "Purch. Rcpt. Header";
        PurchInvoiceHeader: Record "Purch. Inv. Header";
        ImportHeaderLoc: Record "PO Import Header";
        SetupMgt: Codeunit "Order Integration Setup Mgt.";
        OrderCreated: Boolean;
    begin
        if not ImportHeader.FindSet() then
            exit;

        repeat

            if ImportHeader."Purchase Order No." = '' then begin
                if Codeunit.Run(Codeunit::"PO Import Worker", ImportHeader) then begin
                    PurchReceiptHeader.SetRange("Order No.", ImportHeaderLoc."Purchase Order No.");
                    PurchReceiptHeader.FindLast();
                    ImportHeaderLoc.Get(ImportHeader."Entry No.");
                    ImportHeaderLoc."Receipt No." := PurchReceiptHeader."No.";
                    PurchInvoiceHeader.SetRange("Order No.", ImportHeaderLoc."Purchase Order No.");
                    PurchInvoiceHeader.FindLast();
                    ImportHeaderLoc."Invoice No." := PurchInvoiceHeader."No.";
                    ImportHeaderLoc.Status := ImportHeaderLoc.Status::Processed;
                    ImportHeaderLoc."Error Message" := '';
                end else begin
                    ImportHeaderLoc.Get(ImportHeader."Entry No.");
                    ImportHeaderLoc.Status := ImportHeaderLoc.Status::Error;
                    ImportHeaderLoc."Error Message" := CopyStr(GetLastErrorText(), 1, MaxStrLen(ImportHeaderLoc."Error Message"));
                end;
                ImportHeaderLoc.Modify(true);
            end;

            if SetupMgt.IsPurchaseWebhookEnabled() then begin
                ImportHeaderLoc.Get(ImportHeader."Entry No.");
                if Codeunit.Run(Codeunit::"PO Import Webhook", ImportHeaderLoc) then begin
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