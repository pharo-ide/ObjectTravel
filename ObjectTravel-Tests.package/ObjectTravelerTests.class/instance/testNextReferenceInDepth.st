tests
testNextReferenceInDepth

	| traveler |
	traveler := ObjectTraveler on: (20@10 corner: 40@50).
	
	traveler nextReference; nextReference.
	
	traveler nextReference should equal: 20