navigation
moveToNextReference
	(self isAtStart and: [self isNodeEmpty: currentNode ]) ifTrue: [ ^false ].		
	depthRouteForced ifTrue: [ 
		"It is special flag that traveler is forced to visit extra object in depth direction.
		Look at #atNextStepVisit:".
		depthRouteForced := false.
		currentNode := pathNodes last.
		currentReferenceIndex := 0 ]. 
	
	^self moveBreadthToNextReference or: [ 
			self moveBreadthToFirstReference.
			self moveDepthToNextReference]