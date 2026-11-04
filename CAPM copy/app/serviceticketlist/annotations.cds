using crudService as service from '../../srv/crudService';

annotate service.ServiceTicket with @(

    UI.SelectionFields : [
        ticket_number,
        customer_guid.customer_id,
        customer_guid.SITE_GUID.country,
        reported_date,
        Items.item_number,
        Items.description,
        priority_status_code
    ],

    UI.LineItem : [
    {
        $Type : 'UI.DataField',
        Value : ticket_number
    },
    {
        $Type : 'UI.DataField',
        Value : customer_guid.customer_id
    },
    {
        $Type : 'UI.DataField',
        Value : customer_guid.SITE_GUID.country
    },
    {
        $Type : 'UI.DataField',
        Value : reported_date
    },
    {
        $Type : 'UI.DataField',
        Value : Items.item_number
    },
    {
        $Type : 'UI.DataField',
        Value : Items.description
    },
    {
        $Type : 'UI.DataField',
        Value : priority_status_code,
        Criticality : CriticalityField
    }
]

);

annotate service.ServiceTicket with {
    @Common.Text:priorityStatus
    priority_status;
};
