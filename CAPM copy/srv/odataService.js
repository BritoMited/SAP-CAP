import cds from '@sap/cds'

export class odataService extends cds.ApplicationService { init() {

  this.on ('customFunction', async (req) => {
    console.log('On customFunction', req.data)
    return 'Hello ' + req.data.name;
  })

  return super.init()
}}
