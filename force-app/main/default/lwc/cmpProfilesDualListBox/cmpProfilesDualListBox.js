import { LightningElement,  track, wire, api} from 'lwc';
import getAllProfileNames from '@salesforce/apex/CTRL_Announcement.getAllProfilesNames';


export default class CmpProfilesDualListBox extends LightningElement {
	@track profiles;
	@api selectedprofiles;	
	@track loaded = false;
	@track error;

	@wire(getAllProfileNames)
	wireAllProfileNames({ error, data }) {
		if (data) {
			this.profiles = data;
			this.loaded = true;			
        } else if (error)  {
            this.error = error;
			this.loaded = true;	
        }
	}

	handleChange(event) {
		this.dispatchEvent(new CustomEvent('portfolioselected', {detail: event.detail.value}));
    }
}