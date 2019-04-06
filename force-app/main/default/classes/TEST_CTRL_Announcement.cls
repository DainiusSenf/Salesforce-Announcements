/**
 * Created by daini on 19/02/04.
 */
@IsTest(SeeAllData=false)
public with sharing class TEST_CTRL_Announcement
{
	private static User testUser;
	private final static String ANNOUNCEMENT_NAME = 'Random Name';    

	private static void setup()
	{
		List<PicklistValue> profiles = CTRL_Announcement.getAllProfilesNames();
		Profile profile = DAL_Profile.getProfileByName(DAL_Profile.PROFILE_STANDARD_USER);

		testUser = DAL_User.newUser(profile.Id);
		insert testUser;
	}

	static testMethod void testGetAnnouncementByProfile()
	{
		setup();

		Announcement__c announcement = DAL_Announcement.insertNewAnnouncement(
				ANNOUNCEMENT_NAME,
				DAL_Profile.PROFILE_STANDARD_USER,
				System.now(),
				System.now().addHours(5)
		);

		Announcement__c currentUserAnnouncement = CTRL_Announcement.getLatestAnnouncement();
		System.assertEquals(null, currentUserAnnouncement);

		System.runAs(testUser)
		{
			Announcement__c testUserAnnouncement = CTRL_Announcement.getLatestAnnouncement();
			System.assertEquals(announcement.Id, testUserAnnouncement.Id);
		}
	}

	static testMethod void testGetAnnouncement_notStarted()
	{
		setup();

		Announcement__c announcement = DAL_Announcement.insertNewAnnouncement(
				ANNOUNCEMENT_NAME,
				DAL_Profile.PROFILE_STANDARD_USER,
				System.now().addHours(5),
				null
		);

		Announcement__c currentUserAnnouncement = CTRL_Announcement.getLatestAnnouncement();
		System.assertEquals(null, currentUserAnnouncement);

		System.runAs(testUser)
		{
			Announcement__c testUserAnnouncement = CTRL_Announcement.getLatestAnnouncement();
			System.assertEquals(null, testUserAnnouncement);
		}
	}

	static testMethod void testGetAnnouncement_alreadyEnded()
	{
		setup();

		Announcement__c announcement = DAL_Announcement.insertNewAnnouncement(
				ANNOUNCEMENT_NAME,
				DAL_Profile.PROFILE_STANDARD_USER,
				System.now().addHours(-5),
				System.now().addHours(-2)
		);

		Announcement__c currentUserAnnouncement = CTRL_Announcement.getLatestAnnouncement();
		System.assertEquals(null, currentUserAnnouncement);

		System.runAs(testUser)
		{
			Announcement__c testUserAnnouncement = CTRL_Announcement.getLatestAnnouncement();
			System.assertEquals(null, testUserAnnouncement);
		}
	}

	static testMethod void testGetAnnouncement_noProfile()
	{
		setup();

		Announcement__c announcement = DAL_Announcement.insertNewAnnouncement(
				ANNOUNCEMENT_NAME,
				'',
				System.now().addHours(-5),
				null
		);

		Announcement__c currentUserAnnouncement = CTRL_Announcement.getLatestAnnouncement();
		System.assertEquals(announcement.Id, currentUserAnnouncement.Id);

		System.runAs(testUser)
		{
			Announcement__c testUserAnnouncement = CTRL_Announcement.getLatestAnnouncement();
			System.assertEquals(announcement.Id, testUserAnnouncement.Id);
		}
	}

	static testMethod void testGetAnnouncement_showLatestAnnouncement()
	{
		setup();

		Announcement__c firstAnnouncement = DAL_Announcement.insertNewAnnouncement(
				ANNOUNCEMENT_NAME,
				'',
				System.now().addHours(-3),
				null
		);

		Announcement__c secondAnnouncement = DAL_Announcement.insertNewAnnouncement(
				ANNOUNCEMENT_NAME,
				'',
				System.now().addHours(-2),
				null
		);

		Announcement__c currentUserAnnouncement = CTRL_Announcement.getLatestAnnouncement();
		System.assertEquals(secondAnnouncement.Id, currentUserAnnouncement.Id);

		System.runAs(testUser)
		{
			Announcement__c testUserAnnouncement = CTRL_Announcement.getLatestAnnouncement();
			System.assertEquals(secondAnnouncement.Id, testUserAnnouncement.Id);
		}
	}
}