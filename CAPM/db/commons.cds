namespace aulas.cap1;

type Guid : String(32);

using {Currency} from '@sap/cds/common';

type AmountT : Decimal(15,2) @(
    Semantics.amount.currencyCode: 'currency_code'
);

aspect Amount {
    currency : Currency;
    gross_amount : AmountT;
    net_amount : AmountT;
    tax_amount : AmountT;
}