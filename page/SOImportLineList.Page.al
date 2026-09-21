page 50104 "SO Import Line List"
{
    PageType = List;
    SourceTable = "SO Import Line";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.") { ApplicationArea = All; ToolTip = 'Specifies the entry number of the sales import line.'; }
                field("Header Entry No."; Rec."Header Entry No.") { ApplicationArea = All; ToolTip = 'Specifies the entry number of the related sales import header.'; }
                field("Line No."; Rec."Line No.") { ApplicationArea = All; ToolTip = 'Specifies the line number of the sales import line.'; }
                field("External Line No."; Rec."External Line No.") { ApplicationArea = All; ToolTip = 'Specifies the line number from the external source system.'; }
                field("Item No."; Rec."Item No.") { ApplicationArea = All; ToolTip = 'Specifies the item to add to the sales order.'; }
                field(Description; Rec.Description) { ApplicationArea = All; ToolTip = 'Specifies the description of the sales import line.'; }
                field(Quantity; Rec.Quantity) { ApplicationArea = All; ToolTip = 'Specifies the quantity to add to the sales order.'; }
                field("Unit Price"; Rec."Unit Price") { ApplicationArea = All; ToolTip = 'Specifies the unit price for the sales order line.'; }
            }
        }
    }
}