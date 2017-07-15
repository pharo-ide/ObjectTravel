operations
replaceReferenceOf: anObject at: referenceIndex with: replacementObject

	| instSize basicSize |
	instSize := (self classOf: anObject) instSize.
	basicSize := self sizeOf: anObject.
	
	basicSize = 0
		ifTrue: [ ^anObject instVarAt: referenceIndex put: replacementObject].
		
	^referenceIndex <= instSize
		ifTrue: [anObject instVarAt: referenceIndex put: replacementObject  ]
		ifFalse: [ anObject basicAt: referenceIndex - instSize put: replacementObject  ]
		
	 