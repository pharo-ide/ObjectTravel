"
I am mirror for objects which structure should not be traversable. Such objects I call empty
"
Class {
	#name : #EmptyObjectTravelGuide,
	#superclass : #ObjectTravelGuide,
	#category : 'ObjectTravel'
}

{ #category : #navigation }
EmptyObjectTravelGuide class >> isNode: anObject hasLastReferenceAt: referenceIndex [
	^true
]

{ #category : #navigation }
EmptyObjectTravelGuide class >> isNodeEmpty: anObject [
	^true
]

{ #category : #navigation }
EmptyObjectTravelGuide class >> referenceOf: anObject atIndex: referenceIndex [
	self error: 'empty object has no references!'
]

{ #category : #operations }
EmptyObjectTravelGuide class >> replaceReferenceOf: anObject at: referenceIndex with: replacementObject [

	self error: 'empty object dont have references'
]
