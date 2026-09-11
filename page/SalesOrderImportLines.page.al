namespace Jops.Trial;

page 50102 "Jops SO Import Lines"
{
    PageType = API;
    SourceTable = "Jops SO Import Line";
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
            field(id; Rec.SystemId) { }
            field(entryNo; Rec."Entry No.") { }
            field(headerEntryNo; Rec."Header Entry No.") { }
            field(lineNo; Rec."Line No.") { }
            field(externalLineNo; Rec."External Line No.") { }
            field(itemNo; Rec."Item No.") { }
            field(description; Rec.Description) { }
            field(quantity; Rec.Quantity) { }
            field(unitPrice; Rec."Unit Price") { }
        }
    }
}