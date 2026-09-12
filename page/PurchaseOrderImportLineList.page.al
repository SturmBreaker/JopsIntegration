namespace Jops.Trial;

page 50128 "PO Import Line List"
{
    PageType = List;
    SourceTable = "PO Import Line";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.") { ApplicationArea = All; ToolTip = 'Specifies the entry number of the purchase import line.'; }
                field("Header Entry No."; Rec."Header Entry No.") { ApplicationArea = All; ToolTip = 'Specifies the entry number of the related purchase import header.'; }
                field("Line No."; Rec."Line No.") { ApplicationArea = All; ToolTip = 'Specifies the line number of the purchase import line.'; }
                field("External Line No."; Rec."External Line No.") { ApplicationArea = All; ToolTip = 'Specifies the line number from the external source system.'; }
                field("Item No."; Rec."Item No.") { ApplicationArea = All; ToolTip = 'Specifies the item to add to the purchase order.'; }
                field(Description; Rec.Description) { ApplicationArea = All; ToolTip = 'Specifies the description of the purchase import line.'; }
                field(Quantity; Rec.Quantity) { ApplicationArea = All; ToolTip = 'Specifies the quantity to add to the purchase order.'; }
                field("Unit Cost"; Rec."Unit Cost") { ApplicationArea = All; ToolTip = 'Specifies the direct unit cost for the purchase order line.'; }
            }
        }
    }
}