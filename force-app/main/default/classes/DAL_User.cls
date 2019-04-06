public class DAL_User
{
	public static final String FIELD_COUNTRY = User.Country.getDescribe().getLocalName();
	public static final String FIELD_EMAIL_ENCODING_KEY = User.EmailEncodingKey.getDescribe().getLocalName();

	public static final String FIELD_PROFILE = 'ProfileId';
	public static final String FIELD_USER_NAME = User.Username.getDescribe().getLocalName();
	public static final String FIELD_PROFILE_NAME = 'Profile.Name';
	public static final String SYSTEM_ADMINISTRATOR_PROFILE = 'System Administrator';

	private static final String TIMEZONE = 'America/Los_Angeles';
	private static final String LASTNAME = 'Testing';
	private static final String ENCODING_KEY = 'UTF-8';
	private static final String EN_US = 'en_US';
	private static final String EMAIL = 'announcement_test_user@announcement.announcement';
	private static final String ALIAS = 'test123';

	public static User getCurrentUser()
	{
		return
		[
			SELECT
				Id,
				Username,
				FirstName,
				LastName,
				Email,
				TimeZoneSidKey,
				LocaleSidKey,
				EmailEncodingKey,
				LanguageLocaleKey,
				UserRoleId,
				UserType,
				ContactId,
				Profile.Name
			FROM
				User
			WHERE
				Id = :UserInfo.getUserId()
		];
	}

	public static User newUser(Id profileId)
	{
		User newUser = new User
				(
						Alias = ALIAS,
						Email = EMAIL,
						EmailEncodingKey = ENCODING_KEY,
						LastName = LASTNAME,
						LanguageLocaleKey = EN_US,
						LocalesIdKey = EN_US,
						TimezoneSidKey = TIMEZONE,
						Username = eMail,
						isActive = true,
						ProfileId = profileId
				);

		return newUser;
	}
}