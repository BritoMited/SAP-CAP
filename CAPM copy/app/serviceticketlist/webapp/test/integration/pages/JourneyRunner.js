sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"service/ticket/serviceticketlist/test/integration/pages/ServiceTicketList.gen",
	"service/ticket/serviceticketlist/test/integration/pages/ServiceTicketObjectPage.gen",
	"service/ticket/serviceticketlist/test/integration/pages/ServiceTicketItemObjectPage.gen"
], function (JourneyRunner, ServiceTicketListGenerated, ServiceTicketObjectPageGenerated, ServiceTicketItemObjectPageGenerated) {
    'use strict';

    const runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('service/ticket/serviceticketlist') + '/test/flp.html#app-preview',
        pages: {
			onTheServiceTicketListGenerated: ServiceTicketListGenerated,
			onTheServiceTicketObjectPageGenerated: ServiceTicketObjectPageGenerated,
			onTheServiceTicketItemObjectPageGenerated: ServiceTicketItemObjectPageGenerated
        },
        async: true
    });

    return runner;
});

