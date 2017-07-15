tests
testCountingRefereces

	| traveler actual |
	traveler := ObjectTraveler on: 10@20.
	
	actual := traveler countReferences.

	actual should be: 2