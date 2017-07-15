tests
testReplacingReferenceInArray

	| traveler source |
	source := #(1 2 3) copy.
	traveler := ObjectTraveler on: source.
	
	traveler moveToNextReference: 2.
	traveler currentReference should be: 2.
	traveler replaceCurrentReferenceWith: #newReference.
	
	source should equal: #(1 #newReference 3)