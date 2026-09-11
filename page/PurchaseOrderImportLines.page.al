namespace Jops.Trial;

page 50125 "Jops PO Import Lines"
{
    PageType = API;
    SourceTable = "Jops PO Import Line";
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
            field(id; Rec.SystemId) { }
            field(entryNo; Rec."Entry No.") { }
            field(headerEntryNo; Rec."Header Entry No.") { }
            field(lineNo; Rec."Line No.") { }
            field(externalLineNo; Rec."External Line No.") { }
            field(itemNo; Rec."Item No.") { }
            field(description; Rec.Description) { }
            field(quantity; Rec.Quantity) { }
            field(unitCost; Rec."Unit Cost") { }
        }
    }
}