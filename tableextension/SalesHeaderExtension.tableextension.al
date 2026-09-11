namespace Jops.Trial;

using Microsoft.Sales.Document;

tableextension 50113 "Jops Sales Header Extension" extends "Sales Header"
{
    fields
    {
        field(50113; "Source System"; Enum "Jops Order Source System")
        {
            Caption = 'Source System';
            DataClassification = CustomerContent;
        }
    }
}