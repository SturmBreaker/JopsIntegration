namespace Jops.Trial;

using Microsoft.Sales.Document;

pageextension 50114 "Jops SO List Extension" extends "Sales Order List"
{
    layout
    {
        addlast(Control1)
        {
            field("Source System"; Rec."Source System")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the external system that created the sales order.';
            }
        }
    }
}