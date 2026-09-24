codeunit 50135 "TO Import Processor"
{
    TableNo = "TO Import Header";

    trigger OnRun()
    begin
        ProcessPending();
    end;

    procedure ProcessPending()
    var
        ImportHeader: Record "TO Import Header";
    begin
        ImportHeader.SetRange(Status, ImportHeader.Status::Pending);
        ImportHeader.SetFilter("Shipment No.", '=%1', '');
        ImportHeader.SetFilter("Receipt No.", '=%1', '');
        ProcessHeaders(ImportHeader);
    end;

    procedure ProcessSelected(var ImportHeader: Record "TO Import Header")
    begin
        ImportHeader.SetRange(Status, ImportHeader.Status::Pending);
        ImportHeader.SetFilter("Shipment No.", '=%1', '');
        ImportHeader.SetFilter("Receipt No.", '=%1', '');
        ProcessHeaders(ImportHeader);
    end;

    local procedure ProcessHeaders(var ImportHeader: Record "TO Import Header")
    var
        ImportHeaderLoc: Record "TO Import Header";
        TransferShipmentHeader: Record "Transfer Shipment Header";
        TransferReceiptHeader: Record "Transfer Receipt Header";
        SetupMgt: Codeunit "Order Integration Setup Mgt.";
    begin
        if not ImportHeader.FindSet() then
            exit;

        repeat
            if ImportHeader."Transfer Order No." = '' then begin
                if Codeunit.Run(Codeunit::"TO Import Worker", ImportHeader) then begin
                    ImportHeaderLoc.Get(ImportHeader."Entry No.");
                    ImportHeader.Status := ImportHeader.Status::Processed;
                    ImportHeader."Error Message" := '';
                    TransferShipmentHeader.SetRange("Transfer Order No.", ImportHeader."Transfer Order No.");
                    TransferShipmentHeader.FindLast();
                    ImportHeader."Shipment No." := TransferShipmentHeader."No.";
                    TransferReceiptHeader.SetRange("Transfer Order No.", ImportHeader."Transfer Order No.");
                    TransferReceiptHeader.FindLast();
                    ImportHeader."Receipt No." := TransferReceiptHeader."No.";
                    ImportHeaderLoc.Status := ImportHeaderLoc.Status::Processed;
                    ImportHeaderLoc."Error Message" := '';
                end else begin
                    ImportHeaderLoc.Get(ImportHeader."Entry No.");
                    ImportHeaderLoc.Status := ImportHeaderLoc.Status::Error;
                    ImportHeaderLoc."Error Message" := CopyStr(GetLastErrorText(), 1, MaxStrLen(ImportHeaderLoc."Error Message"));
                end;
                ImportHeaderLoc.Modify(true);
            end;

            if SetupMgt.IsTransferWebhookEnabled() then begin
                ImportHeaderLoc.Get(ImportHeader."Entry No.");
                if Codeunit.Run(Codeunit::"TO Import Webhook", ImportHeaderLoc) then begin
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