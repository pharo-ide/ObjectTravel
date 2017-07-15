navigation
referenceOf: anObject atIndex: referenceIndex

	| instSize basicSize |
	instSize := (self classOf: anObject) instSize.
	basicSize := (self sizeOf: anObject).
	
	basicSize = 0
		ifTrue: [ ^anObject instVarAt: referenceIndex].
		
	^referenceIndex <= instSize
		ifTrue: [anObject instVarAt: referenceIndex  ]
		ifFalse: [ anObject basicAt: referenceIndex - instSize ]