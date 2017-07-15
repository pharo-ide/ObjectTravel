testing
isTraversed: anObject
	^(traversedObjects includes: anObject)
		or: [ nodesFilter notNil and: [(nodesFilter value: currentReference) not] ]