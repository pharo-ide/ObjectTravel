navigation
nextReferenceIfEnd: endBlock

	^self moveToNextReference ifTrue: [ currentReference  ] ifFalse: endBlock