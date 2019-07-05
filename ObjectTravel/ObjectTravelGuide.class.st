"
I provide mirrors hierarchy to discover object references
"
Class {
	#name : #ObjectTravelGuide,
	#superclass : #Object,
	#category : 'ObjectTravel'
}

{ #category : #mirrors }
ObjectTravelGuide class >> classOf: anObject [

	<primitive: 111>
	self primitiveFailed
]

{ #category : #navigation }
ObjectTravelGuide class >> isNode: anObject hasLastReferenceAt: referenceIndex [
	self subclassResponsibility 
]

{ #category : #navigation }
ObjectTravelGuide class >> isNodeEmpty: anObject [
	self subclassResponsibility 
]

{ #category : #navigation }
ObjectTravelGuide class >> referenceOf: anObject atIndex: referenceIndex [
	self subclassResponsibility 
]

{ #category : #operations }
ObjectTravelGuide class >> replaceReferenceOf: anObject at: referenceIndex with: replacementObject [
	self subclassResponsibility 
]

{ #category : #mirrors }
ObjectTravelGuide class >> sizeOf: anObject [
	
	<primitive: 62>
	"The number of indexable fields of fixed-length objects is 0"
	^0
]
