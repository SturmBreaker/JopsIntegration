namespace Jops.Trial;

codeunit 50140 "TO Import Archive"
{
    TableNo = "TO Import Header";

    trigger OnRun()
    begin
        ArchiveFiltered(0D, 0D, '', '');
    end;

    procedure ArchiveFiltered(FromDate: Date; ToDate: Date; TransferOrderNo: Code[20]; ItemNo: Code[20])
    var
        ImportHeader: Record "TO Import Header";
    begin
        ImportHeader.SetFilter(Status, '<>%1', ImportHeader.Status::Pending);
        if (FromDate <> 0D) and (ToDate <> 0D) then
            ImportHeader.SetRange("Order Date", FromDate, ToDate)
        else
            if FromDate <> 0D then
                ImportHeader.SetFilter("Order Date", '>=%1', FromDate)
            else
                if ToDate <> 0D then
                    ImportHeader.SetFilter("Order Date", '<=%1', ToDate);
        if TransferOrderNo <> '' then
            ImportHeader.SetRange("Transfer Order No.", TransferOrderNo);

        if ImportHeader.FindSet() then
            repeat
                if (ItemNo = '') or HasItem(ImportHeader."Entry No.", ItemNo) then
                    ArchiveHeader(ImportHeader);
            until ImportHeader.Next() = 0;
    end;

    local procedure HasItem(HeaderEntryNo: Integer; ItemNo: Code[20]): Boolean
    var
        ImportLine: Record "TO Import Line";
    begin
        ImportLine.SetRange("Header Entry No.", HeaderEntryNo);
        ImportLine.SetRange("Item No.", ItemNo);
        exit(not ImportLine.IsEmpty());
    end;

    local procedure ArchiveHeader(var ImportHeader: Record "TO Import Header")
    var
        ArchiveHeaderRecord: Record "TO Import Header Archive";
        ImportLine: Record "TO Import Line";
        ArchiveLine: Record "TO Import Line Archive";
    begin
        ArchiveHeaderRecord.Init();
        ArchiveHeaderRecord."Entry No." := ImportHeader."Entry No.";
        ArchiveHeaderRecord."External Document No." := ImportHeader."External Document No.";
        ArchiveHeaderRecord."Transfer-from Code" := ImportHeader."Transfer-from Code";
        ArchiveHeaderRecord."Transfer-to Code" := ImportHeader."Transfer-to Code";
        ArchiveHeaderRecord."Order Date" := ImportHeader."Order Date";
        ArchiveHeaderRecord.Status := ImportHeader.Status;
        ArchiveHeaderRecord."Error Message" := ImportHeader."Error Message";
        ArchiveHeaderRecord."Received At" := ImportHeader."Received At";
        ArchiveHeaderRecord."Transfer Order No." := ImportHeader."Transfer Order No.";
        ArchiveHeaderRecord."Webhook Status" := ImportHeader."Webhook Status";
        ArchiveHeaderRecord."Webhook Error Message" := ImportHeader."Webhook Error Message";
        ArchiveHeaderRecord."Archived At" := CurrentDateTime();
        ArchiveHeaderRecord.Insert();

        ImportLine.SetRange("Header Entry No.", ImportHeader."Entry No.");
        if ImportLine.FindSet() then
            repeat
                ArchiveLine.Init();
                ArchiveLine."Entry No." := ImportLine."Entry No.";
                ArchiveLine."Header Entry No." := ImportLine."Header Entry No.";
                ArchiveLine."Line No." := ImportLine."Line No.";
                ArchiveLine."External Line No." := ImportLine."External Line No.";
                ArchiveLine."Item No." := ImportLine."Item No.";
                ArchiveLine.Description := ImportLine.Description;
                ArchiveLine.Quantity := ImportLine.Quantity;
                ArchiveLine.Insert();
            until ImportLine.Next() = 0;

        ImportLine.DeleteAll();
        ImportHeader.Delete();
    end;
}