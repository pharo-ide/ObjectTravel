operations
referencesDo: aBlock

	[self moveToNextReference] whileTrue: [ 
		aBlock value: currentReference 
	]