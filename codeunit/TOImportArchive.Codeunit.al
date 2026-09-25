codeunit 50140 "TO Import Archive"
{
    TableNo = "TO Import Header";

    trigger OnRun()
    var
        ImportHeader: Record "TO Import Header";
    begin
        ImportHeader.SetRange(Status, ImportHeader.Status::Processed);
        ArchiveFiltered(ImportHeader);
    end;

    procedure ArchiveFiltered(var ImportHeader: Record "TO Import Header")
    begin
        if ImportHeader.FindSet() then
            repeat
                ArchiveHeader(ImportHeader);
            until ImportHeader.Next() = 0;
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
        ArchiveHeaderRecord."Shipment No." := ImportHeader."Shipment No.";
        ArchiveHeaderRecord."Receipt No." := ImportHeader."Receipt No.";
        ArchiveHeaderRecord."Direct Transfer No." := ImportHeader."Direct Transfer No.";
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