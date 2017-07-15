tests
testGettingStartNode

	| traveler actual |
	traveler := ObjectTraveler on: #start.
	
	actual := traveler startNode.

	actual should be: #start