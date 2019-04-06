/**
 * Created by daini on 19/01/31.
 */

global with sharing class CTRL_Announcement
{
	@AuraEnabled(cacheable=true)
	global static Announcement__c getLatestAnnouncement()
	{
		User user = DAL_User.getCurrentUser();
		Announcement__c announcement = DAL_Announcement.getLatestAnnouncement();
		if(announcement == null)
			return null;
		if(String.isBlank(announcement.Profile_Group__c))
			return announcement;
		List<String> announcementProfiles = announcement.Profile_Group__c.split(',');
		if(announcementProfiles.contains(user.Profile.Name))
			return announcement;
		return null;
	}

	@AuraEnabled(cacheable=true)
	global static List<PicklistValue> getAllProfilesNames()
	{
		List<String> profilesNames = DAL_Profile.getAllProfilesNames();
		List<PicklistValue> options = new List<PicklistValue>();
		for (String profileName : profilesNames)
			options.add(new PicklistValue(profileName));
		return options;
	}
}