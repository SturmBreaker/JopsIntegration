namespace Jops.Trial;

using Microsoft.Inventory.Transfer;

pageextension 50146 "TO List Extension" extends "Transfer Orders"
{
    layout
    {
        addlast(Control1)
        {
            field("Source System"; Rec."Source System")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the external system that created the transfer order.';
            }
        }
    }
}