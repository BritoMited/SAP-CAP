import cds from '@sap/cds'

export class crudService extends cds.ApplicationService { init() {

  const { Technician, serviceTicket, Customer, ServiceSite, SparePart, serviceTicketItem } = cds.entities('crudService')

  this.before (['CREATE', 'UPDATE'], Technician, async (req) => {

    if (!req.data.country_code) {
      req.error(400, 'Country is required');
    }

    if (req.data.country_code !== 'USA') {
      req.error(400, 'Only technicians from USA can be created or updated'); // teste de regra do handler
    }

    console.log('Before CREATE/UPDATE Technician', req.data)

  })

  this.after ('READ', Technician, async (technician, req) => {
    console.log('After READ Technician', technician)

    const rows = Array.isArray(technician)
      ? technician
      : [technician]

    for (const tech of rows) {
      tech.fullName = `${tech.nameFirst || ''} ${tech.nameLast || ''}`.trim()
    }

    for (const tech of rows) {
      tech.fullName1 = `${tech.nameFirst || ''} ${tech.nameLast || ''}`.trim()
    }

  })

  this.before (['CREATE', 'UPDATE'], serviceTicket, async (req) => {
    console.log('Before CREATE/UPDATE serviceTicket', req.data)
  })
  this.after ('READ', serviceTicket, async (serviceTicket, req) => {
    console.log('After READ serviceTicket', serviceTicket)
  })
  this.before (['CREATE', 'UPDATE'], Customer, async (req) => {
    console.log('Before CREATE/UPDATE Customer', req.data)
  })
  this.after ('READ', Customer, async (customer, req) => {
    console.log('After READ Customer', customer)
  })
  this.before (['CREATE', 'UPDATE'], ServiceSite, async (req) => {
    console.log('Before CREATE/UPDATE ServiceSite', req.data)
  })
  this.after ('READ', ServiceSite, async (serviceSite, req) => {
    console.log('After READ ServiceSite', serviceSite)
  })
  this.before (['CREATE', 'UPDATE'], SparePart, async (req) => {
    console.log('Before CREATE/UPDATE SparePart', req.data)
  })
  this.after ('READ', SparePart, async (sparePart, req) => {
    console.log('After READ SparePart', sparePart)
  })
  this.before (['CREATE', 'UPDATE'], serviceTicketItem, async (req) => {
    console.log('Before CREATE/UPDATE serviceTicketItem', req.data)
  })
  this.after ('READ', serviceTicketItem, async (serviceTicketItem, req) => {
    console.log('After READ serviceTicketItem', serviceTicketItem)
  })

  this.on('getFullNameTechnician', Technician, async (req)=>{
    const {ID} = req.params[0];

    const technician = await
    SELECT.one.from(Technician).
    columns('nameFirst','nameLast').
    where({ID:ID});

    if(!technician) {
      req.error(500, 'Technician not found');
    }

    const stringv = `${technician.nameFirst} ${technician.nameLast}`;

    return stringv;

  });

  this.on('updatePhoneNumber', Technician, async (req)=>{
    const {ID} = req.params[0];

    await UPDATE(Technician).
    set({phone:req.data.newPhone}).
    where({ID:ID})

    return 'Phone Updated Successfully'

  })

  this.on('getFullNamesTechnicians', async (req)=>{

  const technicians = await SELECT.from(Technician).columns('nameFirst','nameLast');

  return technicians.map(tech => `${tech.nameFirst} ${tech.nameLast}`);

  });

  this.on('getHighestPaidTechnician', async (req) => {
    const highestPaidTechnician = await SELECT.one
    .from(Technician)
    .columns('nameFirst', 'nameLast', 'salaryAmount')
    .orderBy('salaryAmount desc')
    .limit(1);

    if (!highestPaidTechnician) {
    req.error(404, 'No technicians found');
    }

    return highestPaidTechnician;
  });

  this.on('resetAllTechnicianPhones', async (req)=>{
    await UPDATE(Technician).set({phone:1234435345});
    return 'All technician phone numbers have been reset';
  });
  
  return super.init()
}}
