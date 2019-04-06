global class PicklistValue
	{
		@AuraEnabled public String label { get; set; }
		@AuraEnabled public String value { get; set; }

		public PicklistValue(String option)
		{
			this.label = option;
			this.value = option;
		}

		public PicklistValue(String label, String value)
		{
			this.label = label;
			this.value = value;
		}
	}