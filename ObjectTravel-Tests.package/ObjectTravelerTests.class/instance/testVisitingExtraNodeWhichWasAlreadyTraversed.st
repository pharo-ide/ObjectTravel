tests
testVisitingExtraNodeWhichWasAlreadyTraversed
	| traversed traveler anotherObject |
	traversed := OrderedCollection new.
	traveler := ObjectTraveler on: 10 @ 20.
	anotherObject := 30 @ 50.
	traveler skip: anotherObject.
	
	traveler referencesDo: [ :each | 
			traversed add: each.
			each = 10 ifTrue: [traveler atNextStepVisit: anotherObject]].
		
	traversed should equal: {10 . 20}