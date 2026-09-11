namespace Jops.Trial;

page 50142 "Jops TO Import Lines"
{
    PageType = API;
    SourceTable = "Jops TO Import Line";
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
            field(id; Rec.SystemId) { }
            field(entryNo; Rec."Entry No.") { }
            field(headerEntryNo; Rec."Header Entry No.") { }
            field(lineNo; Rec."Line No.") { }
            field(externalLineNo; Rec."External Line No.") { }
            field(itemNo; Rec."Item No.") { }
            field(description; Rec.Description) { }
            field(quantity; Rec.Quantity) { }
        }
    }
}