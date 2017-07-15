tests
testCountingReferecesWhenGraphWithLoops

	| traveler repeatedObject source actual |
	repeatedObject := 20@10.
	source := repeatedObject -> (repeatedObject -> 40).
	traveler := ObjectTraveler on: source.
	
	actual := traveler countReferences.

	actual should be: 6