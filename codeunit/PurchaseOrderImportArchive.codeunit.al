namespace Jops.Trial;

codeunit 50123 "Jops PO Import Archive"
{
    TableNo = "Jops PO Import Header";

    trigger OnRun()
    begin
        ArchiveFiltered(0D, 0D, '', '');
    end;

    procedure ArchiveFiltered(FromDate: Date; ToDate: Date; PurchaseOrderNo: Code[20]; ItemNo: Code[20])
    var
        ImportHeader: Record "Jops PO Import Header";
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
        if PurchaseOrderNo <> '' then
            ImportHeader.SetRange("Purchase Order No.", PurchaseOrderNo);

        if ImportHeader.FindSet() then
            repeat
                if (ItemNo = '') or HasItem(ImportHeader."Entry No.", ItemNo) then
                    ArchiveHeader(ImportHeader);
            until ImportHeader.Next() = 0;
    end;

    local procedure HasItem(HeaderEntryNo: Integer; ItemNo: Code[20]): Boolean
    var
        ImportLine: Record "Jops PO Import Line";
    begin
        ImportLine.SetRange("Header Entry No.", HeaderEntryNo);
        ImportLine.SetRange("Item No.", ItemNo);
        exit(not ImportLine.IsEmpty());
    end;

    local procedure ArchiveHeader(var ImportHeader: Record "Jops PO Import Header")
    var
        ArchiveHeader: Record "Jops PO Import Header Archive";
        ImportLine: Record "Jops PO Import Line";
        ArchiveLine: Record "Jops PO Import Line Archive";
    begin
        ArchiveHeader.Init();
        ArchiveHeader."Entry No." := ImportHeader."Entry No.";
        ArchiveHeader."External Document No." := ImportHeader."External Document No.";
        ArchiveHeader."Vendor No." := ImportHeader."Vendor No.";
        ArchiveHeader."Order Date" := ImportHeader."Order Date";
        ArchiveHeader."Currency Code" := ImportHeader."Currency Code";
        ArchiveHeader.Status := ImportHeader.Status;
        ArchiveHeader."Error Message" := ImportHeader."Error Message";
        ArchiveHeader."Received At" := ImportHeader."Received At";
        ArchiveHeader."Purchase Order No." := ImportHeader."Purchase Order No.";
        ArchiveHeader."Webhook Status" := ImportHeader."Webhook Status";
        ArchiveHeader."Webhook Error Message" := ImportHeader."Webhook Error Message";
        ArchiveHeader."Archived At" := CurrentDateTime();
        ArchiveHeader.Insert();

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