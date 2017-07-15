tests
testVisitingTwoExtraNodes

	| traveler nodes |
	traveler := ObjectTraveler on: {1@2. 3@4. 5@6}.
	
	nodes := OrderedCollection new.
	
	traveler referencesDo: [:each | each = (3@4) ifTrue: [
			traveler atNextStepVisit: 8@9; atNextStepVisit: 10@11].
		nodes add: each ].

	nodes should equalInOrder: {1@2. 3@4. 8. 9. 10. 11. 5@6. 1. 2. 3. 4. 5. 6}