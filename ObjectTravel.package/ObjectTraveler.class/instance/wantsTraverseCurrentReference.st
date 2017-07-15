private-testing
wantsTraverseCurrentReference

	self isCurrentReferenceEmpty ifTrue: [ ^false ].
	
	^self isCurrentReferenceEmpty not and: [ (self isTraversed: currentReference) not ]