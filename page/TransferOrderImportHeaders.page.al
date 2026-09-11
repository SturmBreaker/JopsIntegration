namespace Jops.Trial;

page 50141 "Jops TO Import Headers"
{
    PageType = API;
    SourceTable = "Jops TO Import Header";
    APIPublisher = 'jops';
    APIGroup = 'staging';
    APIVersion = 'v1.0';
    EntityName = 'transferOrderImport';
    EntitySetName = 'transferOrderImports';
    ODataKeyFields = SystemId;
    DelayedInsert = true;

    layout
    {
        area(content)
        {
            field(id; Rec.SystemId) { }
            field(entryNo; Rec."Entry No.") { }
            field(externalDocumentNo; Rec."External Document No.") { }
            field(transferFromCode; Rec."Transfer-from Code") { }
            field(transferToCode; Rec."Transfer-to Code") { }
            field(orderDate; Rec."Order Date") { }
            field(status; Rec.Status) { }
            field(errorMessage; Rec."Error Message") { }
            field(transferOrderNo; Rec."Transfer Order No.") { }
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