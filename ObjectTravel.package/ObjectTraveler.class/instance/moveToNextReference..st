navigation
moveToNextReference: steps
	steps timesRepeat: [ self moveToNextReference ifFalse: [ ^false ] ].
	
	^true