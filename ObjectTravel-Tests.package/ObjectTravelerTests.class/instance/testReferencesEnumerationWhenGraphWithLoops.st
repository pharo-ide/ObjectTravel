tests
testReferencesEnumerationWhenGraphWithLoops

	| traversed traveler repeatedObject source |
	traversed := OrderedCollection new.
	repeatedObject := 20@10.
	source := repeatedObject -> (repeatedObject -> 40).
	traveler := ObjectTraveler on: source.
	
	traveler referencesDo: [:each | traversed add: each].

	traversed should equal: {repeatedObject. source value. 20. 10. repeatedObject. 40}