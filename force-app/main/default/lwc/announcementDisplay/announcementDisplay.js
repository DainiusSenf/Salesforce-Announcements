import { LightningElement, track, wire} from 'lwc';
import { getSObjectValue } from '@salesforce/apex';
import getLatestAnnouncement from '@salesforce/apex/CTRL_Announcement.getLatestAnnouncement';

import ANNOUNCEMENT_FIELD from '@salesforce/schema/Announcement__c.Announcement__c';

export default class Announcement_Display extends LightningElement {
	@track loaded = false;
	@track error;
	@track announcementRecord;

	@wire(getLatestAnnouncement)
    wiredAnnouncement({error, data}) {
        if (data) {
			this.announcementRecord = data;
			this.loaded = true;			
        } else if (error) {
            this.error = error;
			this.loaded = true;	
        }
    }

	get announcement() {
		if(this.announcementRecord)
			return getSObjectValue(this.announcementRecord, ANNOUNCEMENT_FIELD);
		return '';
    }
}