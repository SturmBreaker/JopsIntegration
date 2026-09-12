namespace Jops.Trial;

using Microsoft.Purchases.Document;

codeunit 50119 "Jops PO Import Worker"
{
    TableNo = "Jops PO Import Header";

    trigger OnRun()
    begin
        Rec.TestField(Status, Rec.Status::Pending);
        CreatePurchaseOrder(Rec);
    end;

    local procedure CreatePurchaseOrder(var ImportHeader: Record "Jops PO Import Header")
    var
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        ImportLine: Record "Jops PO Import Line";
        NextLineNo: Integer;
    begin
        PurchaseHeader.Init();
        PurchaseHeader."Document Type" := PurchaseHeader."Document Type"::Order;
        PurchaseHeader.Insert(true);
        PurchaseHeader.Validate("Buy-from Vendor No.", ImportHeader."Vendor No.");
        PurchaseHeader.Validate("Source System", Enum::"Jops Order Source System"::System1);
        if ImportHeader."Order Date" <> 0D then
            PurchaseHeader.Validate("Posting Date", ImportHeader."Order Date");
        if ImportHeader."Currency Code" <> '' then
            PurchaseHeader.Validate("Currency Code", ImportHeader."Currency Code");
        PurchaseHeader.Validate("Vendor Order No.", ImportHeader."External Document No.");
        PurchaseHeader.Modify(true);

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

            PurchaseLine.Init();
            PurchaseLine."Document Type" := PurchaseHeader."Document Type";
            PurchaseLine."Document No." := PurchaseHeader."No.";
            PurchaseLine."Line No." := NextLineNo;
            PurchaseLine.Insert(true);
            PurchaseLine.Validate(Type, PurchaseLine.Type::Item);
            PurchaseLine.Validate("No.", ImportLine."Item No.");
            if ImportLine.Description <> '' then
                PurchaseLine.Validate(Description, ImportLine.Description);
            PurchaseLine.Validate(Quantity, ImportLine.Quantity);
            PurchaseLine.Validate("Direct Unit Cost", ImportLine."Unit Cost");
            PurchaseLine.Modify(true);
            NextLineNo += 10000;
        until ImportLine.Next() = 0;

        ImportHeader."Purchase Order No." := PurchaseHeader."No.";
        ImportHeader.Modify(true);
    end;
}