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
        field(6; "Enable Sales Webhook"; Boolean)
        {
            Caption = 'Enable Sales Webhook';
            InitValue = false;
        }
        field(7; "Sales Webhook HTTP Endpoint"; Text[2048])
        {
            Caption = 'Sales Webhook HTTP Endpoint';
        }
        field(8; "Enable Purchase Webhook"; Boolean)
        {
            Caption = 'Enable Purchase Webhook';
            InitValue = false;
        }
        field(9; "Purchase Webhook HTTP Endpoint"; Text[2048])
        {
            Caption = 'Purchase Webhook HTTP Endpoint';
        }
        field(10; "Enable Transfer Webhook"; Boolean)
        {
            Caption = 'Enable Transfer Webhook';
            InitValue = false;
        }
        field(11; "Transfer Webhook HTTP Endpoint"; Text[2048])
        {
            Caption = 'Transfer Webhook HTTP Endpoint';
        }
    }

    keys
    {
        key(PK; "Primary Key") { Clustered = true; }
    }
}
