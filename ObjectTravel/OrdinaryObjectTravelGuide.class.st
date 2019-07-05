"
I am mirror for ordinary objects which structure can be traversed generally
"
Class {
	#name : #OrdinaryObjectTravelGuide,
	#superclass : #ObjectTravelGuide,
	#category : 'ObjectTravel'
}

{ #category : #navigation }
OrdinaryObjectTravelGuide class >> isNode: anObject hasLastReferenceAt: referenceIndex [

	^referenceIndex >= ((self classOf: anObject) instSize + (self sizeOf: anObject))
]

{ #category : #navigation }
OrdinaryObjectTravelGuide class >> isNodeEmpty: anObject [

	^(self classOf: anObject) instSize + (self sizeOf: anObject) = 0
]

{ #category : #navigation }
OrdinaryObjectTravelGuide class >> referenceOf: anObject atIndex: referenceIndex [

	| instSize basicSize |
	instSize := (self classOf: anObject) instSize.
	basicSize := (self sizeOf: anObject).
	
	basicSize = 0
		ifTrue: [ ^anObject instVarAt: referenceIndex].
		
	^referenceIndex <= instSize
		ifTrue: [anObject instVarAt: referenceIndex  ]
		ifFalse: [ anObject basicAt: referenceIndex - instSize ]
]

{ #category : #operations }
OrdinaryObjectTravelGuide class >> replaceReferenceOf: anObject at: referenceIndex with: replacementObject [

	| instSize basicSize |
	instSize := (self classOf: anObject) instSize.
	basicSize := self sizeOf: anObject.
	
	basicSize = 0
		ifTrue: [ ^anObject instVarAt: referenceIndex put: replacementObject].
		
	^referenceIndex <= instSize
		ifTrue: [anObject instVarAt: referenceIndex put: replacementObject  ]
		ifFalse: [ anObject basicAt: referenceIndex - instSize put: replacementObject  ]
		
	 
]
