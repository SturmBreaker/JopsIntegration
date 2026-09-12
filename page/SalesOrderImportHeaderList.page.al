namespace Jops.Trial;

page 50103 "Jops SO Import Header List"
{
    PageType = List;
    SourceTable = "Jops SO Import Header";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.") { ApplicationArea = All; }
                field("External Document No."; Rec."External Document No.") { ApplicationArea = All; }
                field("Customer No."; Rec."Customer No.") { ApplicationArea = All; }
                field("Order Date"; Rec."Order Date") { ApplicationArea = All; }
                field(Status; Rec.Status) { ApplicationArea = All; }
                field("Received At"; Rec."Received At") { ApplicationArea = All; }
                field("Error Message"; Rec."Error Message") { ApplicationArea = All; }
                field("Sales Order No."; Rec."Sales Order No.") { ApplicationArea = All; }
                field("Webhook Status"; Rec."Webhook Status") { ApplicationArea = All; }
                field("Webhook Error Message"; Rec."Webhook Error Message") { ApplicationArea = All; }
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
                    ImportProcessor: Codeunit "Jops SO Import Processor";
                    ImportHeader: Record "Jops SO Import Header";
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
                    Report.RunModal(Report::"Jops SO Archive Report");
                    CurrPage.Update(false);
                end;
            }
        }
    }
}