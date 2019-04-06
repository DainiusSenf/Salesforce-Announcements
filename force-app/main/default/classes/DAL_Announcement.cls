/**
 * Created by daini on 19/01/31.
 */

public with sharing class DAL_Announcement
{
	public static Announcement__c getLatestAnnouncement()
	{
		List<Announcement__c> announcements =
			[
				SELECT
						Name,
						Announcement__c,
						Start_Date__c,
						End_Date__c,
						Profile_Group__c
				FROM
						Announcement__c
				WHERE
					(End_Date__c >=: System.Now()
					OR End_Date__c = null)
				AND
					Start_Date__c <=: System.Now()
				ORDER BY Start_Date__c DESC
				LIMIT 1
			];
		if(announcements.isEmpty())
			return null;
		return announcements.get(0);
	}

	public static Announcement__c newAnnouncement(
			String announcement,
			String profilesString,
			Datetime startDateTime,
			Datetime endDatetime
	)
	{
		return new Announcement__c(
				Announcement__c = announcement,
				Profile_Group__c = profilesString,
				Start_Date__c = startDateTime,
				End_Date__c = endDatetime
		);
	}

	public static Announcement__c insertNewAnnouncement(
			String announcement,
			String profilesString,
			Datetime startDateTime,
			Datetime endDatetime
	)
	{
		Announcement__c newAnnouncement = newAnnouncement(announcement, profilesString, startDateTime, endDatetime);
		insert newAnnouncement;
		return newAnnouncement;
	}
}