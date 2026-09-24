page 50109 "SO Import Header Archive List"
{
    Caption = 'Sales Order Import Archive';
    PageType = List;
    UsageCategory = History;
    ApplicationArea = All;
    SourceTable = "SO Import Header Archive";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.") { ApplicationArea = All; ToolTip = 'Specifies the entry number of the sales import.'; }
                field("External Document No."; Rec."External Document No.") { ApplicationArea = All; ToolTip = 'Specifies the document number from the external source system.'; }
                field("Customer No."; Rec."Customer No.") { ApplicationArea = All; ToolTip = 'Specifies the customer for the sales order.'; }
                field("Order Date"; Rec."Order Date") { ApplicationArea = All; ToolTip = 'Specifies the order date for the sales order.'; }
                field(Status; Rec.Status) { ApplicationArea = All; ToolTip = 'Specifies the processing status of the sales import.'; }
                field("Sales Order No."; Rec."Sales Order No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the sales order number used to create the posted documents.';

                    trigger OnDrillDown()
                    var
                        SalesHeader: Record "Sales Header";
                    begin
                        if SalesHeader.Get(SalesHeader."Document Type"::Order, Rec."Sales Order No.") then
                            Page.Run(Page::"Sales Order", SalesHeader);
                    end;
                }
                field("Shipment No."; Rec."Shipment No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the posted sales shipment number.';

                    trigger OnDrillDown()
                    var
                        SalesShipmentHeader: Record "Sales Shipment Header";
                    begin
                        if SalesShipmentHeader.Get(Rec."Shipment No.") then
                            Page.Run(Page::"Posted Sales Shipment", SalesShipmentHeader);
                    end;
                }
                field("Invoice No."; Rec."Invoice No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the posted sales invoice number.';

                    trigger OnDrillDown()
                    var
                        SalesInvoiceHeader: Record "Sales Invoice Header";
                    begin
                        if SalesInvoiceHeader.Get(Rec."Invoice No.") then
                            Page.Run(Page::"Posted Sales Invoice", SalesInvoiceHeader);
                    end;
                }
                field("Archived At"; Rec."Archived At") { ApplicationArea = All; ToolTip = 'Specifies when the sales import was archived.'; }
                field("Received At"; Rec."Received At") { ApplicationArea = All; ToolTip = 'Specifies when the sales import was received.'; }
                field("Error Message"; Rec."Error Message") { ApplicationArea = All; ToolTip = 'Specifies the error message recorded during processing.'; }
                field("Webhook Status"; Rec."Webhook Status") { ApplicationArea = All; ToolTip = 'Specifies the status of the sales status webhook.'; }
                field("Webhook Error Message"; Rec."Webhook Error Message") { ApplicationArea = All; ToolTip = 'Specifies the error message from the sales status webhook.'; }
            }
        }
    }
}
