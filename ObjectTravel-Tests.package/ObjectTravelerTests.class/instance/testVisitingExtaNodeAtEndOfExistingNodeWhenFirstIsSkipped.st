tests
testVisitingExtaNodeAtEndOfExistingNodeWhenFirstIsSkipped

	| traveler nodes source |
	source := {1@2. 3@4}.
	traveler := ObjectTraveler on: source.
	traveler skip: source first.
	
	nodes := OrderedCollection new.

	traveler referencesDo: [:each | each = (3@4) ifTrue: [traveler atNextStepVisit: 8@9].
		nodes add: each ].

	nodes should equalInOrder: {1@2. 3@4. 8. 9. 3. 4}