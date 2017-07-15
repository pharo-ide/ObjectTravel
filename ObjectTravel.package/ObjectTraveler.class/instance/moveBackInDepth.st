private-navigation
moveBackInDepth

	| leftNode |
	leftNode := pathNodes removeLast.
	path removeLast.
	currentNode := pathNodes last.
	currentReferenceIndex := path last.
	leaveNodeAction ifNotNil: [ leaveNodeAction value: leftNode ]