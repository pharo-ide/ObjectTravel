tests
testVisitingExtraNodeTwice
	| traversed traveler anotherObject |
	traversed := OrderedCollection new.
	traveler := ObjectTraveler on: 10 @ 20.
	anotherObject := 30 @ 50.
	
	traveler referencesDo: [ :each | 
			traversed add: each.
			each = 10 ifTrue: [
				traveler atNextStepVisit: anotherObject; atNextStepVisit: anotherObject]].
		
	traversed should equal: {10 . 20 . 30 . 50}