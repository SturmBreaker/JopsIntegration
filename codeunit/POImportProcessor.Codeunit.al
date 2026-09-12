namespace Jops.Trial;

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
        ProcessHeaders(ImportHeader);
    end;

    procedure ProcessSelected(var ImportHeader: Record "PO Import Header")
    begin
        ImportHeader.SetRange(Status, ImportHeader.Status::Pending);
        ProcessHeaders(ImportHeader);
    end;

    local procedure ProcessHeaders(var ImportHeader: Record "PO Import Header")
    begin
        if not ImportHeader.FindSet() then
            exit;

        repeat
            if Codeunit.Run(Codeunit::"PO Import Worker", ImportHeader) then begin
                ImportHeader.Status := ImportHeader.Status::Processed;
                ImportHeader."Error Message" := '';
            end else begin
                ImportHeader.Status := ImportHeader.Status::Error;
                ImportHeader."Error Message" := CopyStr(GetLastErrorText(), 1, MaxStrLen(ImportHeader."Error Message"));
            end;
            ImportHeader."Webhook Status" := ImportHeader."Webhook Status"::Pending;
            ImportHeader."Webhook Error Message" := '';
            ImportHeader.Modify(true);
            Commit();

            if Codeunit.Run(Codeunit::"PO Import Webhook", ImportHeader) then begin
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
}