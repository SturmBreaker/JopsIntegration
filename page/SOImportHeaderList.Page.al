page 50103 "SO Import Header List"
{
    PageType = List;
    SourceTable = "SO Import Header";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.") { ApplicationArea = All; ToolTip = 'Specifies the entry number of the sales import.'; }
                field("External Document No."; Rec."External Document No.") { ApplicationArea = All; ToolTip = 'Specifies the document number from the external source system.'; }
                field("Customer No."; Rec."Customer No.") { ApplicationArea = All; ToolTip = 'Specifies the customer for the sales order.'; }
                field("Order Date"; Rec."Order Date") { ApplicationArea = All; ToolTip = 'Specifies the order date for the sales order.'; }
                field(Status; Rec.Status) { ApplicationArea = All; ToolTip = 'Specifies the processing status of the sales import.'; }
                field("Received At"; Rec."Received At") { ApplicationArea = All; ToolTip = 'Specifies when the sales import was received.'; }
                field("Error Message"; Rec."Error Message") { ApplicationArea = All; ToolTip = 'Specifies the error message recorded during processing.'; }
                field("Sales Order No."; Rec."Sales Order No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the sales order number used to create the posted documents.';

                    trigger OnDrillDown()
                    var
                        SalesHeader: Record "Sales Header";
                    begin
                        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
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
                field("Webhook Status"; Rec."Webhook Status") { ApplicationArea = All; ToolTip = 'Specifies the status of the sales status webhook.'; }
                field("Webhook Error Message"; Rec."Webhook Error Message") { ApplicationArea = All; ToolTip = 'Specifies the error message from the sales status webhook.'; }
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
                promoted = true;
                PromotedIsBig = true;
                ToolTip = 'Create sales orders from the selected pending staging records.';

                trigger OnAction()
                var
                    ImportProcessor: Codeunit "SO Import Processor";
                    ImportHeader: Record "SO Import Header";
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
                promoted = true;
                PromotedIsBig = true;
                ToolTip = 'Archive processed and errored staging records using optional date, sales order, and item filters.';

                trigger OnAction()
                var
                begin
                    Report.RunModal(Report::"SO Archive Report");
                    CurrPage.Update(false);
                end;
            }
            action(ClearErrors)
            {
                ApplicationArea = All;
                Caption = 'Clear Errors';
                Image = ClearLog;
                promoted = true;
                PromotedIsBig = true;
                ToolTip = 'Reset selected sales imports to pending and clear their error messages.';

                trigger OnAction()
                var
                    ImportHeader: Record "SO Import Header";
                begin
                    CurrPage.SetSelectionFilter(ImportHeader);
                    if ImportHeader.FindSet(true) then
                        repeat
                            ImportHeader.Status := ImportHeader.Status::Pending;
                            ImportHeader."Error Message" := '';
                            ImportHeader."Webhook Error Message" := '';
                            ImportHeader.Modify();
                        until ImportHeader.Next() = 0;
                    CurrPage.Update(false);
                end;
            }
        }
    }
}