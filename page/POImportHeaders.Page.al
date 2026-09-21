page 50124 "PO Import Headers"
{
    PageType = API;
    SourceTable = "PO Import Header";
    APIPublisher = 'jops';
    APIGroup = 'staging';
    APIVersion = 'v1.0';
    EntityName = 'purchaseOrderImport';
    EntitySetName = 'purchaseOrderImports';
    ODataKeyFields = SystemId;
    DelayedInsert = true;

    layout
    {
        area(content)
        {
            field(id; Rec.SystemId) { ToolTip = 'Specifies the unique identifier of the purchase import.'; }
            field(entryNo; Rec."Entry No.") { ToolTip = 'Specifies the entry number of the purchase import.'; }
            field(externalDocumentNo; Rec."External Document No.") { ToolTip = 'Specifies the document number from the external source system.'; }
            field(vendorNo; Rec."Vendor No.") { ToolTip = 'Specifies the vendor for the purchase order.'; }
            field(orderDate; Rec."Order Date") { ToolTip = 'Specifies the order date for the purchase order.'; }
            field(currencyCode; Rec."Currency Code") { ToolTip = 'Specifies the currency for the purchase order.'; }
            field(status; Rec.Status) { ToolTip = 'Specifies the processing status of the purchase import.'; }
            field(errorMessage; Rec."Error Message") { ToolTip = 'Specifies the error message recorded during processing.'; }
            field(purchaseOrderNo; Rec."Purchase Order No.") { ToolTip = 'Specifies the created purchase order number.'; }
            field(receiptNo; Rec."Receipt No.") { ToolTip = 'Specifies the posted purchase receipt number.'; }
            field(invoiceNo; Rec."Invoice No.") { ToolTip = 'Specifies the posted purchase invoice number.'; }
            field(webhookStatus; Rec."Webhook Status") { ToolTip = 'Specifies the status of the purchase status webhook.'; }
            field(webhookErrorMessage; Rec."Webhook Error Message") { ToolTip = 'Specifies the error message from the purchase status webhook.'; }
            field(receivedAt; Rec."Received At") { ToolTip = 'Specifies when the purchase import was received.'; }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Status := Rec.Status::Pending;
        Rec."Received At" := CurrentDateTime();
        exit(true);
    end;
}