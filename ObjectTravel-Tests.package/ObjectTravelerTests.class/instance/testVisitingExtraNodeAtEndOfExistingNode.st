tests
testVisitingExtraNodeAtEndOfExistingNode

	| traveler nodes |
	traveler := ObjectTraveler on: {1@2. 3@4}.
	
	nodes := OrderedCollection new.

	traveler referencesDo: [:each | each = (3@4) ifTrue: [traveler atNextStepVisit: 8@9].
		nodes add: each ].

	nodes should equalInOrder: {1@2. 3@4. 8. 9. 1. 2. 3. 4}