tests
testCollectingRefereces

	| traveler actual |
	traveler := ObjectTraveler on: {10@20. 30@50}.
	
	actual := traveler collectReferences.

	actual should equal: { 10@20. 30@50. 10. 20. 30. 50 }