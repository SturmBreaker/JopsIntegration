namespace Jops.Trial;

page 50101 "Jops SO Import Headers"
{
    PageType = API;
    SourceTable = "Jops SO Import Header";
    APIPublisher = 'jops';
    APIGroup = 'staging';
    APIVersion = 'v1.0';
    EntityName = 'salesOrderImport';
    EntitySetName = 'salesOrderImports';
    ODataKeyFields = SystemId;
    DelayedInsert = true;

    layout
    {
        area(content)
        {
            field(id; Rec.SystemId) { }
            field(entryNo; Rec."Entry No.") { }
            field(externalDocumentNo; Rec."External Document No.") { }
            field(customerNo; Rec."Customer No.") { }
            field(orderDate; Rec."Order Date") { }
            field(currencyCode; Rec."Currency Code") { }
            field(status; Rec.Status) { }
            field(errorMessage; Rec."Error Message") { }
            field(salesOrderNo; Rec."Sales Order No.") { }
            field(webhookStatus; Rec."Webhook Status") { }
            field(webhookErrorMessage; Rec."Webhook Error Message") { }
            field(receivedAt; Rec."Received At") { }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Status := Rec.Status::Pending;
        Rec."Received At" := CurrentDateTime();
        exit(true);
    end;
}