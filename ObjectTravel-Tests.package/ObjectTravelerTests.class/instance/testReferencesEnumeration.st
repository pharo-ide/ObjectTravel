tests
testReferencesEnumeration

	| traversed traveler |
	traversed := OrderedCollection new.
	traveler := ObjectTraveler on: 10@20.
	
	traveler referencesDo: [:each | traversed add: each].

	traversed should equal: #(10 20)