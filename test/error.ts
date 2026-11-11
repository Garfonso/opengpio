import { NanoPi_NEO3 } from '../src';

console.log('Watch error test');
NanoPi_NEO3.output(NanoPi_NEO3.bcm.GPIO0_D3);

setInterval(() => {
    console.log('Watching the same pin again');
    try {
        NanoPi_NEO3.output(NanoPi_NEO3.bcm.GPIO0_D3);
    } catch (e) {
        console.log('Should catch as JS error', e);
    }
}, 2000);
