tests
testNextReferenceOnEmptyObject

	| traveler |
	traveler := ObjectTraveler on: Object new.
	
	traveler moveToNextReference should be: false