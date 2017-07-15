tests
testReplacingReference

	| traveler repeatedObject source |
	repeatedObject := 20@10.
	source := repeatedObject -> (repeatedObject -> (40@50)).
	traveler := ObjectTraveler on: source.
	
	traveler nextReference should be: repeatedObject.
	traveler replaceCurrentReferenceWith: #newReference.
	
	source key should be: #newReference.
	source value key should be: repeatedObject 