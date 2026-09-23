table 50149 "Order Integration Setup"
{
    Caption = 'Order Integration Setup';

    fields
    {
        field(1; "Primary Key"; Code[10]) { }
        field(2; "Enable API Telemetry"; Boolean)
        {
            Caption = 'Enable API Telemetry';
            InitValue = true;
        }
        field(3; "Enable Sales Posting"; Boolean)
        {
            Caption = 'Enable Sales Posting';
            InitValue = true;
        }
        field(4; "Enable Purchase Posting"; Boolean)
        {
            Caption = 'Enable Purchase Posting';
            InitValue = true;
        }
        field(5; "Enable Transfer Posting"; Boolean)
        {
            Caption = 'Enable Transfer Posting';
            InitValue = true;
        }
    }

    keys
    {
        key(PK; "Primary Key") { Clustered = true; }
    }
}
