tests
testIsAtEndWhenNoReferenceAnymore

	| traveler |
	traveler := ObjectTraveler on: 20@10.
	
	traveler nextReference; nextReference.

	traveler moveToNextReference should be: false