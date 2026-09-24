codeunit 50110 "SO Import Archive"
{
    TableNo = "SO Import Header";

    trigger OnRun()
    var
        ImportHeader: Record "SO Import Header";
    begin
        ImportHeader.SetRange(Status, ImportHeader.Status::Processed);
        ArchiveFiltered(ImportHeader);
    end;

    procedure ArchiveFiltered(var ImportHeader: Record "SO Import Header")
    begin
        if ImportHeader.FindSet() then
            repeat
                ArchiveHeader(ImportHeader);
            until ImportHeader.Next() = 0;
    end;

    local procedure HasItem(HeaderEntryNo: Integer; ItemNo: Code[20]): Boolean
    var
        ImportLine: Record "SO Import Line";
    begin
        ImportLine.SetRange("Header Entry No.", HeaderEntryNo);
        ImportLine.SetRange("Item No.", ItemNo);
        exit(not ImportLine.IsEmpty());
    end;

    local procedure ArchiveHeader(var ImportHeader: Record "SO Import Header")
    var
        ArchiveHeaderRecord: Record "SO Import Header Archive";
        ImportLine: Record "SO Import Line";
        ArchiveLine: Record "SO Import Line Archive";
    begin
        ArchiveHeaderRecord.Init();
        ArchiveHeaderRecord."Entry No." := ImportHeader."Entry No.";
        ArchiveHeaderRecord."External Document No." := ImportHeader."External Document No.";
        ArchiveHeaderRecord."Customer No." := ImportHeader."Customer No.";
        ArchiveHeaderRecord."Order Date" := ImportHeader."Order Date";
        ArchiveHeaderRecord."Currency Code" := ImportHeader."Currency Code";
        ArchiveHeaderRecord.Status := GetArchiveStatus(ImportHeader.Status);
        ArchiveHeaderRecord."Error Message" := ImportHeader."Error Message";
        ArchiveHeaderRecord."Received At" := ImportHeader."Received At";
        ArchiveHeaderRecord."Sales Order No." := ImportHeader."Sales Order No.";
        ArchiveHeaderRecord."Shipment No." := ImportHeader."Shipment No.";
        ArchiveHeaderRecord."Invoice No." := ImportHeader."Invoice No.";
        ArchiveHeaderRecord."Webhook Status" := GetArchiveWebhookStatus(ImportHeader."Webhook Status");
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
                ArchiveLine."Unit Price" := ImportLine."Unit Price";
                ArchiveLine.Insert();
            until ImportLine.Next() = 0;

        ImportLine.SetRange("Header Entry No.", ImportHeader."Entry No.");
        ImportLine.DeleteAll();
        ImportHeader.Delete();
    end;

    local procedure GetArchiveStatus(Status: Option Pending,Processed,Error): Option Pending,Processed,Error
    begin
        exit(Status);
    end;

    local procedure GetArchiveWebhookStatus(Status: Option Pending,Sent,Error): Option Pending,Sent,Error
    begin
        exit(Status);
    end;
}