tests
testCopyObject

	| traveler repeatedObject source copy |
	repeatedObject := 20@10.
	source := repeatedObject -> (repeatedObject -> (40@50)).
	traveler := ObjectTraveler on: source.
	
	copy := traveler copyObject.

	copy key should not be: source key.
	copy value key should be: copy key.
	copy value value should not be: 40@50.
	copy value value should equal: 40@50.