using {aulas.cap.coreBusiness as data} from '../db/schema';
using {aulas.cap.operations as operations} from '../db/schema';

service crudService {

    entity Technician     as projection on data.Technician
    actions{
        function getFullNameTechnician() returns String;
        action updatePhoneNumber(newPhone : String) returns String;
    };

    entity ServiceTicket     as projection on operations.ServiceTicket{
        *,
        case priority_status.code
        when '34' then 'High'
        else 'Unknown'
        end as priorityStatus:String(10),
        case priority_status.code
        when '34' then 1
        else 'Unknown'
        end as CriticalityField:Integer
    };
    entity ServiceTicketItem as projection on operations.ServiceTicketItem;

    entity Customer     as projection on data.Customer;
    entity ServiceSite  as projection on data.ServiceSite;
    entity SparePart    as projection on data.SparePart;

    function getFullNamesTechnicians() returns array of String;
    function getHighestPaidTechnician() returns Technician;
    action resetAllTechnicianPhones() returns String;

}