navigation
alsoLookAt: anotherObject
	self 
		deprecated: 'Use atNextStepVisit: instead'
	 	transformWith: '`@receiver alsoLookAt: `@statements1'
						-> '`@receiver atNextStepVisit: `@statements1'.
		
	self atNextStepVisit: anotherObject 