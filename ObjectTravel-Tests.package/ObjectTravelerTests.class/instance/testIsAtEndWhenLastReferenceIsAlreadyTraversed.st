tests
testIsAtEndWhenLastReferenceIsAlreadyTraversed

	| traveler repeatedObject |
	repeatedObject := 20@10.
	traveler := ObjectTraveler on: (repeatedObject -> repeatedObject).
	
	traveler nextReference; nextReference.
	traveler nextReference; nextReference. "20 and 10"
	
	traveler moveToNextReference should be: false