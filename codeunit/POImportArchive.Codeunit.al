codeunit 50123 "PO Import Archive"
{
    TableNo = "PO Import Header";

    trigger OnRun()
    var
        ImportHeader: Record "PO Import Header";
    begin
        ImportHeader.SetRange(Status, ImportHeader.Status::Processed);
        ArchiveFiltered(ImportHeader);
    end;

    procedure ArchiveFiltered(var ImportHeader: Record "PO Import Header")
    begin
        if ImportHeader.FindSet() then
            repeat
                ArchiveHeader(ImportHeader);
            until ImportHeader.Next() = 0;
    end;

    local procedure HasItem(HeaderEntryNo: Integer; ItemNo: Code[20]): Boolean
    var
        ImportLine: Record "PO Import Line";
    begin
        ImportLine.SetRange("Header Entry No.", HeaderEntryNo);
        ImportLine.SetRange("Item No.", ItemNo);
        exit(not ImportLine.IsEmpty());
    end;

    local procedure ArchiveHeader(var ImportHeader: Record "PO Import Header")
    var
        ArchiveHeaderRecord: Record "PO Import Header Archive";
        ImportLine: Record "PO Import Line";
        ArchiveLine: Record "PO Import Line Archive";
    begin
        ArchiveHeaderRecord.Init();
        ArchiveHeaderRecord."Entry No." := ImportHeader."Entry No.";
        ArchiveHeaderRecord."External Document No." := ImportHeader."External Document No.";
        ArchiveHeaderRecord."Vendor No." := ImportHeader."Vendor No.";
        ArchiveHeaderRecord."Order Date" := ImportHeader."Order Date";
        ArchiveHeaderRecord."Currency Code" := ImportHeader."Currency Code";
        ArchiveHeaderRecord.Status := ImportHeader.Status;
        ArchiveHeaderRecord."Error Message" := ImportHeader."Error Message";
        ArchiveHeaderRecord."Received At" := ImportHeader."Received At";
        ArchiveHeaderRecord."Purchase Order No." := ImportHeader."Purchase Order No.";
        ArchiveHeaderRecord."Receipt No." := ImportHeader."Receipt No.";
        ArchiveHeaderRecord."Invoice No." := ImportHeader."Invoice No.";
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
                ArchiveLine."Unit Cost" := ImportLine."Unit Cost";
                ArchiveLine.Insert();
            until ImportLine.Next() = 0;

        ImportLine.DeleteAll();
        ImportHeader.Delete();
    end;
}