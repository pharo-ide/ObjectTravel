"
I am special mirror to discover CompiledMethod references inside method literals
"
Class {
	#name : #CompiledCodeTravelGuide,
	#superclass : #ObjectTravelGuide,
	#category : #ObjectTravel
}

{ #category : #navigation }
CompiledCodeTravelGuide class >> isNode: aCompiledMethod hasLastReferenceAt: referenceIndex [
	^referenceIndex >= aCompiledMethod numLiterals
]

{ #category : #navigation }
CompiledCodeTravelGuide class >> isNodeEmpty: aCompiledMethod [
	^aCompiledMethod numLiterals = 0
]

{ #category : #navigation }
CompiledCodeTravelGuide class >> referenceOf: aCompiledMethod atIndex: referenceIndex [
	^aCompiledMethod literalAt: referenceIndex 
]

{ #category : #operations }
CompiledCodeTravelGuide class >> replaceReferenceOf: aCompiledMethod at: referenceIndex with: replacementObject [

	aCompiledMethod literalAt: referenceIndex put: replacementObject 
]
