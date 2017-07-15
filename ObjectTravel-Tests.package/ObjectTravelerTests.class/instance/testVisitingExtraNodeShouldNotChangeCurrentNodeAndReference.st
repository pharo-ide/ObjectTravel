tests
testVisitingExtraNodeShouldNotChangeCurrentNodeAndReference

	| traveler root |
	root := {1@2. 3@4. 5@6}.
	traveler := ObjectTraveler on: root.
	
	traveler moveToNextReference; moveToNextReference.
	
	traveler currentNode should be: root.
	traveler currentReference should equal: 3@4.
	
	traveler atNextStepVisit: 8@9.
	
	traveler currentNode should be: root.
	traveler currentReference should equal: 3@4