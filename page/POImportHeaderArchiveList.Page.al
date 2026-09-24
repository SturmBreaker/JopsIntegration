page 50100 "PO Import Header Archive List"
{
    Caption = 'PageName';
    PageType = List;
    UsageCategory = History;
    ApplicationArea = All;
    SourceTable = "PO Import Header Archive";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.") { ApplicationArea = All; ToolTip = 'Specifies the entry number of the purchase import.'; }
                field("External Document No."; Rec."External Document No.") { ApplicationArea = All; ToolTip = 'Specifies the document number from the external source system.'; }
                field("Vendor No."; Rec."Vendor No.") { ApplicationArea = All; ToolTip = 'Specifies the vendor for the purchase order.'; }
                field("Vendor Shipment No."; Rec."Vendor Shipment No.") { ApplicationArea = All; ToolTip = 'Specifies the vendor shipment number for the purchase order.'; }
                field("Vendor Invoice No."; Rec."Vendor Invoice No.") { ApplicationArea = All; ToolTip = 'Specifies the vendor invoice number for the purchase order.'; }
                field("Order Date"; Rec."Order Date") { ApplicationArea = All; ToolTip = 'Specifies the order date for the purchase order.'; }
                field(Status; Rec.Status) { ApplicationArea = All; ToolTip = 'Specifies the processing status of the purchase import.'; }
                field("Purchase Order No."; Rec."Purchase Order No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the purchase order number used to create the posted documents.';

                    trigger OnDrillDown()
                    var
                        PurchaseHeader: Record "Purchase Header";
                    begin
                        if PurchaseHeader.Get(PurchaseHeader."Document Type"::Order, Rec."Purchase Order No.") then
                            Page.Run(Page::"Purchase Order", PurchaseHeader);
                    end;
                }
                field("Receipt No."; Rec."Receipt No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the posted purchase receipt number.';

                    trigger OnDrillDown()
                    var
                        PurchReceiptHeader: Record "Purch. Rcpt. Header";
                    begin
                        if PurchReceiptHeader.Get(Rec."Receipt No.") then
                            Page.Run(Page::"Posted Purchase Receipt", PurchReceiptHeader);
                    end;
                }
                field("Invoice No."; Rec."Invoice No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the posted purchase invoice number.';

                    trigger OnDrillDown()
                    var
                        PurchInvoiceHeader: Record "Purch. Inv. Header";
                    begin
                        if PurchInvoiceHeader.Get(Rec."Invoice No.") then
                            Page.Run(Page::"Posted Purchase Invoice", PurchInvoiceHeader);
                    end;
                }
                field("Archived At"; Rec."Archived At") { ApplicationArea = All; ToolTip = 'Specifies when the purchase import was archived.'; }
                field("Received At"; Rec."Received At") { ApplicationArea = All; ToolTip = 'Specifies when the purchase import was received.'; }
                field("Error Message"; Rec."Error Message") { ApplicationArea = All; ToolTip = 'Specifies the error message recorded during processing.'; }
                field("Webhook Status"; Rec."Webhook Status") { ApplicationArea = All; ToolTip = 'Specifies the status of the purchase status webhook.'; }
                field("Webhook Error Message"; Rec."Webhook Error Message") { ApplicationArea = All; ToolTip = 'Specifies the error message from the purchase status webhook.'; }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}