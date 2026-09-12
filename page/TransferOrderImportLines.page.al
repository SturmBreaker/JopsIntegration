namespace Jops.Trial;

page 50142 "TO Import Lines"
{
    PageType = API;
    SourceTable = "TO Import Line";
    APIPublisher = 'jops';
    APIGroup = 'staging';
    APIVersion = 'v1.0';
    EntityName = 'transferOrderImportLine';
    EntitySetName = 'transferOrderImportLines';
    ODataKeyFields = SystemId;
    DelayedInsert = true;

    layout
    {
        area(content)
        {
            field(id; Rec.SystemId) { ToolTip = 'Specifies the unique identifier of the transfer import line.'; }
            field(entryNo; Rec."Entry No.") { ToolTip = 'Specifies the entry number of the transfer import line.'; }
            field(headerEntryNo; Rec."Header Entry No.") { ToolTip = 'Specifies the entry number of the related transfer import header.'; }
            field(lineNo; Rec."Line No.") { ToolTip = 'Specifies the line number of the transfer import line.'; }
            field(externalLineNo; Rec."External Line No.") { ToolTip = 'Specifies the line number from the external source system.'; }
            field(itemNo; Rec."Item No.") { ToolTip = 'Specifies the item to add to the transfer order.'; }
            field(description; Rec.Description) { ToolTip = 'Specifies the description of the transfer import line.'; }
            field(quantity; Rec.Quantity) { ToolTip = 'Specifies the quantity to add to the transfer order.'; }
        }
    }
}