tests
testTraverseOnlyFilteredNodes

	| traveler nodeToSkip  |
	nodeToSkip := 10@20.
	traveler := ObjectTraveler on: (nodeToSkip corner: 40@50) where: [ :node | node ~= nodeToSkip ].
	
	traveler collectReferences should equal: {nodeToSkip. 40@50. 40. 50}.