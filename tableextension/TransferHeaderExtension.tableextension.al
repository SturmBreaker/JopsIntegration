namespace Jops.Trial;

using Microsoft.Inventory.Transfer;

tableextension 50134 "Transfer Header Ext" extends "Transfer Header"
{
    fields
    {
        field(50134; "Source System"; Enum "Order Source System")
        {
            Caption = 'Source System';
            DataClassification = CustomerContent;
        }
    }
}