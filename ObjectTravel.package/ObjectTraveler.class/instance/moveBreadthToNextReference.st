private-navigation
moveBreadthToNextReference

	(self isAtLastReferenceOfCurrentNode) ifFalse: [ 
			currentReferenceIndex := currentReferenceIndex + 1.
			currentReference := self referenceOf: currentNode atIndex: currentReferenceIndex.
			path atLast: 1 put: currentReferenceIndex.	
			^true].

	path atLast: 1 put: currentReferenceIndex.
	^false