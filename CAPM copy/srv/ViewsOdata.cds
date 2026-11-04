using {aulas.cap.views as views} from '../db/views';

service ViewsOdata @(path: 'ViewsOdata') {
    entity SparePartView as projection on views.views.SparePartView;
    entity TicketItemView as projection on views.views.TicketItemView;
}