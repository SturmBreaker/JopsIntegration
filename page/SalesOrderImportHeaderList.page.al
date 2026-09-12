namespace Jops.Trial;

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
                field("Sales Order No."; Rec."Sales Order No.") { ApplicationArea = All; ToolTip = 'Specifies the created sales order number.'; }
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
                ToolTip = 'Archive processed and errored staging records using optional date, sales order, and item filters.';

                trigger OnAction()
                var
                begin
                    Report.RunModal(Report::"SO Archive Report");
                    CurrPage.Update(false);
                end;
            }
        }
    }
}