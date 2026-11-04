namespace aulas.cap;

using {aulas.cap1 as common} from './commons';
using {
    cuid,
    Country,
    Currency
} from '@sap/cds/common';

context coreBusiness {

    entity Customer {
        key NODE_KEY                 : common.Guid;
            customer_type            : String(32);
            email_adress             : String(32);
            phone_number             : String(32);
            alternative_phone_number : String(32);
            website_url              : String(32);
            customer_name            : String(32);
            customer_id              : String(32);
            SITE_GUID                : Association to one ServiceSite;
            SpareParts               : Association to many SparePart
                                           on SpareParts.customer_guid = $self;
    }

    entity ServiceSite {
        key NODE_KEY    : common.Guid;
            city        : String(255);
            postal_code : String(20);
            street      : String(255);
            building    : String(255);
            country     : String(255);
            site_type   : String(44);
            active_from : Date;
            active_to   : Date;
            latitude    : Decimal(9, 6);
            longitude   : Decimal(9, 6);
            customer    : Association to one Customer
                              on customer.SITE_GUID = $self
    }

    entity Technician : cuid {
        nameFirst     : String(255);
        nameLast      : String(255);
        email_adress  : String(255);
        phone         : String(20);
        gender        : String(1) enum {
            Male = 'M';
            Female = 'F';
            Other = 'O';
        };
        language      : String(5);
        country       : Country;
        currency      : Currency;
        salaryAmount  : Decimal(15, 2) @(Semantic.amount.currencyCode: 'currency_code');
        accountNumber : String(16);
        bankId        : String(40);
        bankName      : String(255);
        Tickets       : Association to many operations.ServiceTicket
                            on Tickets.technician = $self;
        virtual fullname1 : String(255) // não cria campo no banco, é utilizado apenas para o front criando metadata
    }

    entity SparePart {
        key NODE_KEY       : common.Guid;
            part_number    : String(255)    @assert.unique;
            description    : localized String(255);
            price          : Decimal(15, 2) @(Semantic.amount.currencyCode: 'currency_code');
            category       : String(255);
            customer_guid  : Association to one Customer;
            tax_class_code : Integer;
            measure_unit   : String(3);
            weight_measure : Decimal(15, 3);
            weight_unit    : String(3);
            currency_code  : String(4);
            width          : Decimal(15, 3);
            height         : Decimal(15, 3);
            depth          : Decimal(15, 3);
            dim_unit       : String(3);

    }

    entity PriorityCode {
        key code        : String(2);
            description : String(255);
    }

}

context operations {

    entity ServiceTicket : common.Amount, cuid {
        ticket_number   : String(255);
        customer_guid   : Association to one coreBusiness.Customer;
        priority_status : Association to one coreBusiness.PriorityCode;
        technician      : Association to one coreBusiness.Technician;
        overall_status  : String(255);
        note            : String(1000);
        reported_date   : Date;
        reported_time   : Time;
        closed_date     : Date;
        closed_time     : Time;
        Items           : Composition of many ServiceTicketItem
                              on Items.parent = $self;
    }

    entity ServiceTicketItem : common.Amount, cuid {
        parent      : Association to one ServiceTicket;
        item_number     : String(255);
        description     : String(255);
        spare_part_guid : Association to one coreBusiness.SparePart;
    }


}
