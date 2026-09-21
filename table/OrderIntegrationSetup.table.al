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
    }

    keys
    {
        key(PK; "Primary Key") { Clustered = true; }
    }
}
