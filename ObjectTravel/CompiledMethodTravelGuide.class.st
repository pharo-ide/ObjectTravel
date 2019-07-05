"
I am special mirror to discover CompiledMethod references inside method literals
"
Class {
	#name : #CompiledMethodTravelGuide,
	#superclass : #ObjectTravelGuide,
	#category : 'ObjectTravel'
}

{ #category : #navigation }
CompiledMethodTravelGuide class >> isNode: aCompiledMethod hasLastReferenceAt: referenceIndex [
	^referenceIndex >= aCompiledMethod numLiterals
]

{ #category : #navigation }
CompiledMethodTravelGuide class >> isNodeEmpty: aCompiledMethod [
	^aCompiledMethod numLiterals = 0
]

{ #category : #navigation }
CompiledMethodTravelGuide class >> referenceOf: aCompiledMethod atIndex: referenceIndex [
	^aCompiledMethod literalAt: referenceIndex 
]

{ #category : #operations }
CompiledMethodTravelGuide class >> replaceReferenceOf: aCompiledMethod at: referenceIndex with: replacementObject [

	aCompiledMethod literalAt: referenceIndex put: replacementObject 
]
