tests
testTraverseObjectWhereFirstDeepReferenceIsSkipped

	| traveler nodeToSkip |
	nodeToSkip := {2. 3}.
	traveler := ObjectTraveler on: {{nodeToSkip. 4}}.
	traveler skip: nodeToSkip.

	traveler collectReferences should equal: {{nodeToSkip. 4 }. nodeToSkip. 4 }.