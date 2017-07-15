tests
testNextReferenceAtTheStart

	| traveler |
	traveler := ObjectTraveler on: 20@10.
	
	traveler nextReference should equal: 20