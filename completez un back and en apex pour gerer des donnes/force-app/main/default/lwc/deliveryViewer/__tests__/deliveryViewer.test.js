import { createElement } from 'lwc';
import DeliveryViewer from 'c/deliveryViewer';

describe('c-delivery-viewer', () => {
    afterEach(() => {
        while (document.body.firstChild) {
            document.body.removeChild(document.body.firstChild);
        }
    });

    it('renders without crashing', () => {
        const element = createElement('c-delivery-viewer', {
            is: DeliveryViewer
        });
        document.body.appendChild(element);
        expect(element).toBeTruthy();
    });
});