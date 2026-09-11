namespace Jops.Trial;

page 50143 "Jops TO Import Header List"
{
    PageType = List;
    SourceTable = "Jops TO Import Header";
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
                field("Transfer-from Code"; Rec."Transfer-from Code") { ApplicationArea = All; }
                field("Transfer-to Code"; Rec."Transfer-to Code") { ApplicationArea = All; }
                field("Order Date"; Rec."Order Date") { ApplicationArea = All; }
                field(Status; Rec.Status) { ApplicationArea = All; }
                field("Transfer Order No."; Rec."Transfer Order No.") { ApplicationArea = All; }
                field("Received At"; Rec."Received At") { ApplicationArea = All; }
                field("Error Message"; Rec."Error Message") { ApplicationArea = All; }
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
                ToolTip = 'Create transfer orders from the selected pending staging records.';

                trigger OnAction()
                var
                    ImportProcessor: Codeunit "Jops TO Import Processor";
                    ImportHeader: Record "Jops TO Import Header";
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
                ToolTip = 'Archive processed and errored transfer staging records using optional filters.';

                trigger OnAction()
                begin
                    Report.RunModal(Report::"Jops TO Archive Report");
                    CurrPage.Update(false);
                end;
            }
        }
    }
}