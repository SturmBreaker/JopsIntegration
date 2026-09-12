namespace Jops.Trial;

page 50102 "SO Import Lines"
{
    PageType = API;
    SourceTable = "SO Import Line";
    APIPublisher = 'jops';
    APIGroup = 'staging';
    APIVersion = 'v1.0';
    EntityName = 'salesOrderImportLine';
    EntitySetName = 'salesOrderImportLines';
    ODataKeyFields = SystemId;
    DelayedInsert = true;

    layout
    {
        area(content)
        {
            field(id; Rec.SystemId) { ToolTip = 'Specifies the unique identifier of the sales import line.'; }
            field(entryNo; Rec."Entry No.") { ToolTip = 'Specifies the entry number of the sales import line.'; }
            field(headerEntryNo; Rec."Header Entry No.") { ToolTip = 'Specifies the entry number of the related sales import header.'; }
            field(lineNo; Rec."Line No.") { ToolTip = 'Specifies the line number of the sales import line.'; }
            field(externalLineNo; Rec."External Line No.") { ToolTip = 'Specifies the line number from the external source system.'; }
            field(itemNo; Rec."Item No.") { ToolTip = 'Specifies the item to add to the sales order.'; }
            field(description; Rec.Description) { ToolTip = 'Specifies the description of the sales import line.'; }
            field(quantity; Rec.Quantity) { ToolTip = 'Specifies the quantity to add to the sales order.'; }
            field(unitPrice; Rec."Unit Price") { ToolTip = 'Specifies the unit price for the sales order line.'; }
        }
    }
}