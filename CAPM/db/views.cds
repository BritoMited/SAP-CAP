namespace aulas.cap.views;

using {
    aulas.cap.coreBusiness as data,
    aulas.cap.operations   as operations
} from './schema';


context views {

    define view ![CustomerView] as
        select from data.Customer {
            key NODE_KEY          as ![CustomerKey],
                customer_type,
                email_adress,
                phone_number,
                alternative_phone_number,
                website_url,
                customer_name,
                customer_id,
                SITE_GUID.country as ![Country]
        }


    define view ![SparePart] as
        select from data.SparePart {
                @EnduserText.label: [
                    {
                        language: 'en',
                        text    : 'Part Number'
                    },
                    {
                        language: 'de',
                        text    : 'Teilnummer'
                    }
                ]
            key part_number,
                @EnduserText.label: [
                    {
                        language: 'en',
                        text    : 'Description'
                    },
                    {
                        language: 'de',
                        text    : 'Beschreibung'
                    }
                ]
                description
        };

    define view ![TicketItemView] as
        select from operations.ServiceTicketItem {

            key parent.ticket_number                   as ![TicketNumber],
                parent.customer_guid.customer_id       as ![CustomerID],
                parent.technician.nameFirst            as ![TechnicianFirs tName],
                parent.technician.nameLast             as ![TechnicianLastName],
                parent.technician.email_adress         as ![TechnicianEmail],
                parent.technician.phone                as ![TechnicianPhone],
                parent.customer_guid.SITE_GUID.country as ![CustomerCountry],
                spare_part_guid.part_number            as ![PartNumber],
                spare_part_guid.description            as ![SparePartDescription]
        };

    define view ![SparePartView] as
        select from data.SparePart
        mixin {
            TicketItems : Association to many TicketItemView
                              on TicketItems.PartNumber = $projection.PartNumber
        }
        into {
            part_number as ![PartNumber],
            description as ![Description],
            price       as ![Price],
            TicketItems as ![TicketItems]
        };

    define view ![SparePartConsumptionView] as
    select from data.SparePart as part {
        key part.part_number as ![PartNumber],
        part.description as ![Description],
        part.price       as ![Price],
        (
            select count( * ) from operations.ServiceTicketItem as items
            where
                items.spare_part_guid.part_number = part.part_number
        )                as ![ConsumptionCount]
    };

    define view ![PopularSparePartview] as select from SparePartConsumptionView{
        key PartNumber,
        Description,
        Price,
        ConsumptionCount
    }
    where ConsumptionCount > 2;

}
