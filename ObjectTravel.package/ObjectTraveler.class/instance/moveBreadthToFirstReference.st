private-navigation
moveBreadthToFirstReference

	path atLast: 1 put: 1.
	currentReferenceIndex := 1.
	currentReference := self referenceOf: currentNode atIndex: currentReferenceIndex