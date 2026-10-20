table 50150 "Order Integration Cue"
{
    Caption = 'Order Integration Cue';
    DataClassification = SystemMetadata;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }

        // ---------- Sales ----------
        field(10; "SO Unprocessed Headers"; Integer)
        {
            Caption = 'Unprocessed Sales Headers';
            FieldClass = FlowField;
            CalcFormula = count("SO Import Header" where(Status = filter(Pending | Error)));
            Editable = false;
        }
        field(11; "SO Unprocessed Lines"; Integer)
        {
            // Calculated in the Activities page (lines have no status of their own)
            Caption = 'Unprocessed Sales Lines';
            Editable = false;
        }

        // ---------- Purchase ----------
        field(20; "PO Unprocessed Headers"; Integer)
        {
            Caption = 'Unprocessed Purchase Headers';
            FieldClass = FlowField;
            CalcFormula = count("PO Import Header" where(Status = filter(Pending | Error)));
            Editable = false;
        }
        field(21; "PO Unprocessed Lines"; Integer)
        {
            Caption = 'Unprocessed Purchase Lines';
            Editable = false;
        }

        // ---------- Transfer ----------
        field(30; "TO Unprocessed Headers"; Integer)
        {
            Caption = 'Unprocessed Transfer Headers';
            FieldClass = FlowField;
            CalcFormula = count("TO Import Header" where(Status = filter(Pending | Error)));
            Editable = false;
        }
        field(31; "TO Unprocessed Lines"; Integer)
        {
            Caption = 'Unprocessed Transfer Lines';
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}
