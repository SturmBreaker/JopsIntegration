namespace Jops.Trial;

page 50125 "PO Import Lines"
{
    PageType = API;
    SourceTable = "PO Import Line";
    APIPublisher = 'jops';
    APIGroup = 'staging';
    APIVersion = 'v1.0';
    EntityName = 'purchaseOrderImportLine';
    EntitySetName = 'purchaseOrderImportLines';
    ODataKeyFields = SystemId;
    DelayedInsert = true;

    layout
    {
        area(content)
        {
            field(id; Rec.SystemId) { ToolTip = 'Specifies the unique identifier of the purchase import line.'; }
            field(entryNo; Rec."Entry No.") { ToolTip = 'Specifies the entry number of the purchase import line.'; }
            field(headerEntryNo; Rec."Header Entry No.") { ToolTip = 'Specifies the entry number of the related purchase import header.'; }
            field(lineNo; Rec."Line No.") { ToolTip = 'Specifies the line number of the purchase import line.'; }
            field(externalLineNo; Rec."External Line No.") { ToolTip = 'Specifies the line number from the external source system.'; }
            field(itemNo; Rec."Item No.") { ToolTip = 'Specifies the item to add to the purchase order.'; }
            field(description; Rec.Description) { ToolTip = 'Specifies the description of the purchase import line.'; }
            field(quantity; Rec.Quantity) { ToolTip = 'Specifies the quantity to add to the purchase order.'; }
            field(unitCost; Rec."Unit Cost") { ToolTip = 'Specifies the direct unit cost for the purchase order line.'; }
        }
    }
}