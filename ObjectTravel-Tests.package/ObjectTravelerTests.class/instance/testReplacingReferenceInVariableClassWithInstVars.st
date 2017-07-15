tests
testReplacingReferenceInVariableClassWithInstVars

	| traveler source |
	source := WeakMessageSend receiver: 1 selector: #abs.
	traveler := ObjectTraveler on: source.
	
	traveler moveToNextReference.
	traveler currentReference should be: #abs.
	traveler replaceCurrentReferenceWith: #newSelector.

	traveler moveToNextReference; moveToNextReference; moveToNextReference.
	traveler currentReference should be: 1.
	traveler replaceCurrentReferenceWith: #newReceiver.
	
	source receiver should be: #newReceiver.
	source selector should be: #newSelector