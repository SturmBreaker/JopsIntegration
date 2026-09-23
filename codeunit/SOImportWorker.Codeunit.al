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
        SalesShipmentHeader: Record "Sales Shipment Header";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SetupMgt: Codeunit "Order Integration Setup Mgt.";
        SalesOrderNo: Code[20];
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

        SalesOrderNo := SalesHeader."No.";
        if not SetupMgt.IsSalesPostingEnabled() then begin
            ImportHeader."Sales Order No." := SalesOrderNo;
            ImportHeader.Modify(true);
            exit;
        end;

        SalesHeader.Validate(Ship, true);
        SalesHeader.Validate(Invoice, true);
        SalesHeader.Modify(true);

        if not Codeunit.Run(Codeunit::"Sales-Post", SalesHeader) then
            Error('Sales order %1 could not be posted. %2', SalesHeader."No.", GetLastErrorText());

        SalesShipmentHeader.SetRange("Order No.", SalesOrderNo);
        if not SalesShipmentHeader.FindFirst() then
            Error('Posted shipment for sales order %1 could not be found.', SalesOrderNo);
        SalesInvoiceHeader.SetRange("Order No.", SalesOrderNo);
        if not SalesInvoiceHeader.FindFirst() then
            Error('Posted invoice for sales order %1 could not be found.', SalesOrderNo);

        ImportHeader."Sales Order No." := SalesOrderNo;
        ImportHeader."Shipment No." := SalesShipmentHeader."No.";
        ImportHeader."Invoice No." := SalesInvoiceHeader."No.";
        ImportHeader.Modify(true);
    end;
}