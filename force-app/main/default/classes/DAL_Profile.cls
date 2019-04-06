/**
 * Created by daini on 19/01/31.
 */

public with sharing class DAL_Profile
{
	public static final String PROFILE_STANDARD_USER = 'Standard User';
	
	public static List<Profile> getAllProfiles()
	{
		return
		[
			SELECT
					Id,
					Name
			FROM Profile
		];
	}

	public static List<String> getAllProfilesNames()
	{
		List<Profile> profiles = getAllProfiles();
		return UTIL_BaseObject.extractListValues(profiles, UTIL_BaseObject.NAME_FIELD);
	}

	public static Profile getProfileByName(String name)
	{
		List<Profile> profiles = [
				SELECT
					Id
				FROM
						Profile
				WHERE Name =: name
		];
		if (!profiles.isEmpty())
			return profiles.get(0);
		return null;
	}
}