tests
testTraverseOnlyFilteredNodes2

	| traveler rect |
	rect := 1@2 corner: 3@4.
	traveler := ObjectTraveler on: {rect. 5@6} where: [ :node | node isKindOf: Point ].

	traveler collectReferences should equal: {rect. 5@6. 5. 6}.