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
        SetupMgt: Codeunit "Order Integration Setup Mgt.";
        OrderCreated: Boolean;
    begin
        if not ImportHeader.FindSet() then
            exit;

        repeat
            OrderCreated := false;
            if ImportHeader."Transfer Order No." = '' then
                OrderCreated := Codeunit.Run(Codeunit::"TO Import Worker", ImportHeader);

            if OrderCreated or (ImportHeader."Transfer Order No." <> '') then begin
                if SetupMgt.IsTransferPostingEnabled() then
                    PostTransferOrder(ImportHeader)
                else begin
                    ImportHeader.Status := ImportHeader.Status::Processed;
                    ImportHeader."Error Message" := '';
                end;
            end else begin
                ImportHeader.Status := ImportHeader.Status::Error;
                ImportHeader."Error Message" := CopyStr(GetLastErrorText(), 1, MaxStrLen(ImportHeader."Error Message"));
            end;
            ImportHeader."Webhook Status" := ImportHeader."Webhook Status"::Pending;
            ImportHeader."Webhook Error Message" := '';
            ImportHeader.Modify(true);
            Commit();

            if Codeunit.Run(Codeunit::"TO Import Webhook", ImportHeader) then begin
                ImportHeader."Webhook Status" := ImportHeader."Webhook Status"::Sent;
                ImportHeader."Webhook Error Message" := '';
            end else begin
                ImportHeader."Webhook Status" := ImportHeader."Webhook Status"::Error;
                ImportHeader."Webhook Error Message" := CopyStr(GetLastErrorText(), 1, MaxStrLen(ImportHeader."Webhook Error Message"));
            end;
            ImportHeader.Modify(true);
            Commit();
        until ImportHeader.Next() = 0;
    end;

    local procedure PostTransferOrder(var ImportHeader: Record "TO Import Header")
    var
        TransferHeader: Record "Transfer Header";
        TransferShipmentHeader: Record "Transfer Shipment Header";
        TransferReceiptHeader: Record "Transfer Receipt Header";
    begin
        if ImportHeader."Transfer Order No." = '' then
            exit;

        TransferHeader.Get(TransferHeader."No.", ImportHeader."Transfer Order No.");
        if not Codeunit.Run(Codeunit::"TransferOrder-Post Transfer", TransferHeader) then begin
            ImportHeader.Status := ImportHeader.Status::Error;
            ImportHeader."Error Message" := CopyStr(GetLastErrorText(), 1, MaxStrLen(ImportHeader."Error Message"));
        end else begin
            ImportHeader.Status := ImportHeader.Status::Processed;
            ImportHeader."Error Message" := '';
            TransferShipmentHeader.SetRange("Transfer Order No.", ImportHeader."Transfer Order No.");
            TransferShipmentHeader.FindLast();
            ImportHeader."Shipment No." := TransferShipmentHeader."No.";
            TransferReceiptHeader.SetRange("Transfer Order No.", ImportHeader."Transfer Order No.");
            TransferReceiptHeader.FindLast();
            ImportHeader."Receipt No." := TransferReceiptHeader."No.";
        end;
        ImportHeader.Modify(true);
    end;
}