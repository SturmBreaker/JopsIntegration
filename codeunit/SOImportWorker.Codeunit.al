namespace Jops.Trial;

using Microsoft.Sales.Document;
using Microsoft.Sales.Posting;

codeunit 50106 "SO Import Worker"
{
    TableNo = "SO Import Header";

    trigger OnRun()
    begin
        Rec.TestField(Status, Rec.Status::Pending);
        CreateSalesOrder(Rec);
    end;

    local procedure CreateSalesOrder(var ImportHeader: Record "SO Import Header")
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        ImportLine: Record "SO Import Line";
        NextLineNo: Integer;
    begin
        SalesHeader.Init();
        SalesHeader."Document Type" := SalesHeader."Document Type"::Order;
        SalesHeader.Insert(true);
        SalesHeader.Validate("Sell-to Customer No.", ImportHeader."Customer No.");
        SalesHeader.Validate("Source System", Enum::"Order Source System"::System1);
        if ImportHeader."Order Date" <> 0D then
            SalesHeader.Validate("Posting Date", ImportHeader."Order Date");
        if ImportHeader."Currency Code" <> '' then
            SalesHeader.Validate("Currency Code", ImportHeader."Currency Code");
        SalesHeader.Validate("External Document No.", ImportHeader."External Document No.");
        SalesHeader.Modify(true);

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

            SalesLine.Init();
            SalesLine."Document Type" := SalesHeader."Document Type";
            SalesLine."Document No." := SalesHeader."No.";
            SalesLine."Line No." := NextLineNo;
            SalesLine.Insert(true);
            SalesLine.Validate(Type, SalesLine.Type::Item);
            SalesLine.Validate("No.", ImportLine."Item No.");
            if ImportLine.Description <> '' then
                SalesLine.Validate(Description, ImportLine.Description);
            SalesLine.Validate(Quantity, ImportLine.Quantity);
            SalesLine.Validate("Unit Price", ImportLine."Unit Price");
            SalesLine.Modify(true);
            NextLineNo += 10000;
        until ImportLine.Next() = 0;

        SalesHeader.Validate(Ship, true);
        SalesHeader.Validate(Invoice, true);
        SalesHeader.Modify(true);
        if not Codeunit.Run(Codeunit::"Sales-Post", SalesHeader) then
            Error('Sales order %1 could not be posted. %2', SalesHeader."No.", GetLastErrorText());

        ImportHeader."Sales Order No." := SalesHeader."No.";
        ImportHeader.Modify(true);
    end;
}