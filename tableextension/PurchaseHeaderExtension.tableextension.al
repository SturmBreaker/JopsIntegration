namespace Jops.Trial;

using Microsoft.Purchases.Document;

tableextension 50117 "Jops Purchase Header Ext" extends "Purchase Header"
{
    fields
    {
        field(50117; "Source System"; Enum "Jops Order Source System")
        {
            Caption = 'Source System';
            DataClassification = CustomerContent;
        }
    }
}