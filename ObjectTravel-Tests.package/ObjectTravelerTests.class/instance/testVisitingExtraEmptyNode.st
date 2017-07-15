tests
testVisitingExtraEmptyNode

	| traveler nodes |
	traveler := ObjectTraveler on: {1@2. 3@4. 5@6}.
	
	nodes := OrderedCollection new.
	
	traveler referencesDo: [:each | each = (3@4) ifTrue: [traveler atNextStepVisit: Object new].
		nodes add: each ].

	nodes should equalInOrder: {1@2. 3@4. 5@6. 1. 2. 3. 4. 5. 6}