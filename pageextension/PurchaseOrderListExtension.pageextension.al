namespace Jops.Trial;

using Microsoft.Purchases.Document;

pageextension 50129 "PO List Extension" extends "Purchase Order List"
{
    layout
    {
        addlast(Control1)
        {
            field("Source System"; Rec."Source System")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the external system that created the purchase order.';
            }
        }
    }
}