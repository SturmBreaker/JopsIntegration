tableextension 50117 "Purchase Header Ext" extends "Purchase Header"
{
    fields
    {
        field(50117; "Source System"; Enum "Order Source System")
        {
            Caption = 'Source System';
            DataClassification = CustomerContent;
        }
    }
}