namespace Jops.Trial;

using Microsoft.Inventory.Transfer;

tableextension 50134 "Jops Transfer Header Ext" extends "Transfer Header"
{
    fields
    {
        field(50134; "Source System"; Enum "Jops Order Source System")
        {
            Caption = 'Source System';
            DataClassification = CustomerContent;
        }
    }
}