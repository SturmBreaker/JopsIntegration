page 50127 "PO Import Header List"
{
    PageType = List;
    SourceTable = "PO Import Header";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.") { ApplicationArea = All; ToolTip = 'Specifies the entry number of the purchase import.'; }
                field("External Document No."; Rec."External Document No.") { ApplicationArea = All; ToolTip = 'Specifies the document number from the external source system.'; }
                field("Vendor No."; Rec."Vendor No.") { ApplicationArea = All; ToolTip = 'Specifies the vendor for the purchase order.'; }
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
                field("Received At"; Rec."Received At") { ApplicationArea = All; ToolTip = 'Specifies when the purchase import was received.'; }
                field("Error Message"; Rec."Error Message") { ApplicationArea = All; ToolTip = 'Specifies the error message recorded during processing.'; }
                field("Webhook Status"; Rec."Webhook Status") { ApplicationArea = All; ToolTip = 'Specifies the status of the purchase status webhook.'; }
                field("Webhook Error Message"; Rec."Webhook Error Message") { ApplicationArea = All; ToolTip = 'Specifies the error message from the purchase status webhook.'; }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ProcessSelected)
            {
                ApplicationArea = All;
                Caption = 'Process Selected';
                Image = CreateDocument;
                ToolTip = 'Create purchase orders from the selected pending staging records.';

                trigger OnAction()
                var
                    ImportProcessor: Codeunit "PO Import Processor";
                    ImportHeader: Record "PO Import Header";
                begin
                    CurrPage.SetSelectionFilter(ImportHeader);
                    ImportProcessor.ProcessSelected(ImportHeader);
                    CurrPage.Update(false);
                end;
            }
            action(ArchiveStaging)
            {
                ApplicationArea = All;
                Caption = 'Archive Staging';
                Image = Archive;
                ToolTip = 'Archive processed and errored purchase staging records using optional filters.';

                trigger OnAction()
                var
                begin
                    Report.RunModal(Report::"PO Archive Report");
                    CurrPage.Update(false);
                end;
            }
        }
    }
}