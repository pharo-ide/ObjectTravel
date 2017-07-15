tests
testVisitingExtraNodeInsideAnotherExtraNode

	| traveler nodes source |
	source := {1@2. 3@4. 5@6}.
	traveler := ObjectTraveler on: source.
	
	nodes := OrderedCollection new.

	traveler referencesDo: [:each | 
		each = (3@4) ifTrue: [traveler atNextStepVisit: {7@8. 9@10}].
		each = (9@10) ifTrue: [ traveler atNextStepVisit: 11@12 ].
		nodes add: each ].

	nodes should equalInOrder: {1@2. 3@4. 7@8. 9@10. 11. 12. 7. 8. 9. 10. 5@6. 1. 2. 3. 4. 5. 6}