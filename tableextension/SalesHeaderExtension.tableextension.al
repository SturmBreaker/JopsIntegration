tableextension 50113 "Sales Header Extension" extends "Sales Header"
{
    fields
    {
        field(50113; "Source System"; Enum "Order Source System")
        {
            Caption = 'Source System';
            DataClassification = CustomerContent;
        }
    }
}