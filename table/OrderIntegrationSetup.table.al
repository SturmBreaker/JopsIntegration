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
        field(3; "Enable Real-Time API Processing"; Boolean)
        {
            Caption = 'Enable Real-Time API Processing';
            InitValue = false;
        }
        field(4; "Enable Sales Posting"; Boolean)
        {
            Caption = 'Enable Sales Posting';
            InitValue = true;
        }
        field(5; "Enable Purchase Posting"; Boolean)
        {
            Caption = 'Enable Purchase Posting';
            InitValue = true;
        }
        field(6; "Enable Transfer Posting"; Boolean)
        {
            Caption = 'Enable Transfer Posting';
            InitValue = true;
        }
        field(7; "Enable Sales Webhook"; Boolean)
        {
            Caption = 'Enable Sales Webhook';
            InitValue = false;
        }
        field(8; "Sales Webhook HTTP Endpoint"; Text[2048])
        {
            Caption = 'Sales Webhook HTTP Endpoint';
        }
        field(9; "Enable Purchase Webhook"; Boolean)
        {
            Caption = 'Enable Purchase Webhook';
            InitValue = false;
        }
        field(10; "Purchase Webhook HTTP Endpoint"; Text[2048])
        {
            Caption = 'Purchase Webhook HTTP Endpoint';
        }
        field(11; "Enable Transfer Webhook"; Boolean)
        {
            Caption = 'Enable Transfer Webhook';
            InitValue = false;
        }
        field(12; "Transfer Webhook HTTP Endpoint"; Text[2048])
        {
            Caption = 'Transfer Webhook HTTP Endpoint';
        }
    }

    keys
    {
        key(PK; "Primary Key") { Clustered = true; }
    }
}
