public with sharing class UTIL_BaseObject
{
	public final static String NAME_FIELD = 'Name';
	 
	public static List<String> extractListValues(List<SObject> objects, String fieldName)
	{
		List<String> result = new List<String>();

		if (objects != null)
			for (SObject item : objects)
				result.add((String) item.get(fieldName));

		return result;
	}

}