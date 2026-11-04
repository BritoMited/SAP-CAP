import cds from '@sap/cds'

export class ViewsOdata extends cds.ApplicationService { init() {

  const { SparePartView, TicketItemView } = cds.entities('ViewsOdata')

  this.before (['CREATE', 'UPDATE'], SparePartView, async (req) => {
    console.log('Before CREATE/UPDATE SparePartView', req.data)
  })
  this.after ('READ', SparePartView, async (sparePartView, req) => {
    console.log('After READ SparePartView', sparePartView)
  })
  this.before (['CREATE', 'UPDATE'], TicketItemView, async (req) => {
    console.log('Before CREATE/UPDATE TicketItemView', req.data)
  })
  this.after ('READ', TicketItemView, async (ticketItemView, req) => {
    console.log('After READ TicketItemView', ticketItemView)
  })


  return super.init()
}}
