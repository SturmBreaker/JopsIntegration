namespace Jops.Trial;

using Microsoft.Inventory.Transfer;

codeunit 50136 "Jops TO Import Worker"
{
    TableNo = "Jops TO Import Header";

    trigger OnRun()
    begin
        CreateTransferOrder(Rec);
    end;

    local procedure CreateTransferOrder(var ImportHeader: Record "Jops TO Import Header")
    var
        TransferHeader: Record "Transfer Header";
        TransferLine: Record "Transfer Line";
        ImportLine: Record "Jops TO Import Line";
        NextLineNo: Integer;
    begin
        TransferHeader.Init();
        TransferHeader.Insert(true);
        TransferHeader.Validate("Transfer-from Code", ImportHeader."Transfer-from Code");
        TransferHeader.Validate("Transfer-to Code", ImportHeader."Transfer-to Code");
        TransferHeader.Validate("Source System", Enum::"Jops Order Source System"::System1);
        if ImportHeader."Order Date" <> 0D then
            TransferHeader.Validate("Posting Date", ImportHeader."Order Date");
        TransferHeader.Validate("External Document No.", ImportHeader."External Document No.");
        TransferHeader.Modify(true);

        ImportLine.SetCurrentKey("Header Entry No.", "Line No.");
        ImportLine.SetRange("Header Entry No.", ImportHeader."Entry No.");
        if not ImportLine.FindSet() then
            Error('No lines were found for staging entry %1.', ImportHeader."Entry No.");

        NextLineNo := 10000;
        repeat
            if ImportLine."Item No." = '' then
                Error('Item No. is required for staging line %1.', ImportLine."Entry No.");
            if ImportLine.Quantity <= 0 then
                Error('Quantity must be greater than zero for staging line %1.', ImportLine."Entry No.");

            TransferLine.Init();
            TransferLine."Document No." := TransferHeader."No.";
            TransferLine."Line No." := NextLineNo;
            TransferLine.Insert(true);
            TransferLine.Validate("Item No.", ImportLine."Item No.");
            if ImportLine.Description <> '' then
                TransferLine.Validate(Description, ImportLine.Description);
            TransferLine.Validate(Quantity, ImportLine.Quantity);
            TransferLine.Modify(true);
            NextLineNo += 10000;
        until ImportLine.Next() = 0;

        ImportHeader."Transfer Order No." := TransferHeader."No.";
        ImportHeader.Modify(true);
    end;
}