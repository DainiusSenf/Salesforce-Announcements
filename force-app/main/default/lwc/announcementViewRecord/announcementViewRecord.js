import { LightningElement, api, wire  } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import ANNOUNCEMENT_OBJECT from '@salesforce/schema/Announcement__c';
import PROFILE_GROUP_FIELD from '@salesforce/schema/Announcement__c.Profile_Group__c';

export default class AnnouncementViewRecord extends LightningElement {
	@api recordId;
	announcementObject = ANNOUNCEMENT_OBJECT;

	@wire(getRecord, { recordId: '$recordId', fields: [PROFILE_GROUP_FIELD] })
	record;
	
	get profileGroup() {
		if(this.record && this.record.data) {
			let groupField = getFieldValue(this.record.data, PROFILE_GROUP_FIELD);
			if(groupField)
				return groupField.split(",")
			return '';
		}
        return '';
    }
}