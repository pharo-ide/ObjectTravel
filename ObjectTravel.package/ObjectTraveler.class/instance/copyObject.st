operations
copyObject

	| activeNode copies nodeCopy copy startCopy |
	activeNode := currentNode.
	copies := IdentityDictionary new: 4096.
	copies at: currentNode put: (startCopy := nodeCopy := currentNode shallowCopy).
	
	[self moveToNextReference] whileTrue: [ 
		activeNode == currentNode ifFalse: [ 
			activeNode := currentNode.
			nodeCopy := copies at: activeNode.
		].
		copy := copies at: currentReference ifAbsentPut: [currentReference shallowCopy].	
			
		self replaceReferenceOf: nodeCopy at: currentReferenceIndex with: copy		
	 ].
	
	^startCopy