private-navigation
moveDepthToNextReference

	| newNode |
	[[self wantsTraverseCurrentReference not and: [self moveBreadthToNextReference]] whileTrue.
	
	path size = 1 or: [self wantsTraverseCurrentReference]] whileFalse: [ 
		self moveBackInDepth.
		(currentReferenceIndex <= 0) ifTrue: [ 
			"Depth way was forced by #atNextStepVisit: and now we need to continue walk breadth"
			currentReferenceIndex := currentReferenceIndex negated.
			path atLast: 1 put: currentReferenceIndex.
			^self moveToNextReference].
		self moveBreadthToNextReference
	 ].
			
	self wantsTraverseCurrentReference ifFalse: [ ^false].
	
	newNode := currentReference.
	pathNodes add: newNode.
	path add: 1.		
	traversedObjects add: newNode.
	currentNode := newNode.
	currentReferenceIndex := 1.
	currentReference := self referenceOf: currentNode atIndex: currentReferenceIndex.	
	^true