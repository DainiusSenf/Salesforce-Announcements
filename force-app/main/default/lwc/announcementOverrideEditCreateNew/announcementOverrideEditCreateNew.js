import { LightningElement, track, api, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import { NavigationMixin } from 'lightning/navigation';
import PROFILE_GROUP_FIELD from '@salesforce/schema/Announcement__c.Profile_Group__c';

export default class AnnouncementOverrideCreateNew extends NavigationMixin(LightningElement) {
	@api announcementid;
	@track selectedProfiles;
	@track loaded = false;
	@track error;

	@wire(getRecord, { recordId: '$announcementid', fields: [PROFILE_GROUP_FIELD] })
    wiredAnnouncment({ error, data }) {
        if (data) {
			this.selectedProfiles = data.fields.Profile_Group__c.value;
			if(data.fields.Profile_Group__c) {
				this.selectedProfiles = data.fields.Profile_Group__c.value.split(", ");
			}
        } else if (error) {
            this.error = error;
        }
    }
	
	portfolioSelectedHandler(event) {
		this.selectedProfiles = event.detail;
    }
	handleSubmit(event) {
		event.preventDefault();       // stop the form from submitting
		const fields = event.detail.fields;
		fields.Profile_Group__c = this.selectedProfiles.join(", ");
		this.template.querySelector('lightning-record-edit-form').submit(fields);
	}
	handleSuccess(event) {
		this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: event.detail.id,
                objectApiName: 'Announcement__c', // objectApiName is optional
                actionName: 'view'
            }
        });
	}
	handleCancel() {
		this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                objectApiName: 'Announcement__c', // objectApiName is optional
                actionName: 'list'
            }
        });
	}
}