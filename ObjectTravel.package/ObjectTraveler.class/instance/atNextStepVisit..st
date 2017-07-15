navigation
atNextStepVisit: newObject
	(self isNodeEmpty: newObject) ifTrue: [ ^self ].
	(self isTraversed: newObject) ifTrue: [ ^self ].
	traversedObjects add: newObject. 
	depthRouteForced | (currentReferenceIndex = 0) ifFalse: [ 
		depthRouteForced := true.	
		path atLast: 1 put: currentReferenceIndex negated.
		"Negative reference index or zero is special flag to catch that breadth way was interrupted 
		and traveler turn into depth direction of given extra node (newObject).
		When it will return breadth way will continue (look at #moveDepthToNextReference)"		
		pathNodes add: newObject.
		path add: 0. ^self].
	
	pathNodes add: newObject.
	path add: 0.
	self visitLastExtraNodeInDeclaredOrder. "it could be removed in future"