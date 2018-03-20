tests
testTraverseBlockClosure

	| traveler block refs |
	block := [Point x: 1 y: 10].
	traveler := ObjectTraveler on: block.
	traveler skipAll: {
		block outerContext sender. traveler. traveler class. self class. Point. Identical}.

	refs := traveler collectReferences.
	refs should include: block outerContext.
	refs should include: (Identical to: block).
	refs should include: thisContext method.
	refs should include: self.
	refs size should be < 42