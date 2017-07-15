initialization
startOn: anObject

	pathNodes add: anObject.
	traversedObjects add: anObject.
	currentNode := anObject