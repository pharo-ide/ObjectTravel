operations
referencesDo: aBlock until: conditionBlock

	[self moveToNextReference and: [(conditionBlock value: currentReference) not]] whileTrue: [ 
		aBlock value: currentReference 
	]