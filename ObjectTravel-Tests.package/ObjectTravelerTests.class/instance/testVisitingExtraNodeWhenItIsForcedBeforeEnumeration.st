tests
testVisitingExtraNodeWhenItIsForcedBeforeEnumeration

	| traveler nodes |
	traveler := ObjectTraveler on: {1@2. 3@4. 5@6}.
	traveler atNextStepVisit: 7@8.
	
	nodes := OrderedCollection new.
	
	traveler referencesDo: [:each | nodes add: each ].

	nodes should equalInOrder: {1@2. 3@4. 5@6. 1. 2. 3. 4. 5. 6. 7. 8}