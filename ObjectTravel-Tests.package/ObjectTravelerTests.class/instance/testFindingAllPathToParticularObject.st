tests
testFindingAllPathToParticularObject

	| traveler repeatedObject source result |
	repeatedObject := 20@10.
	source := (0 -> repeatedObject) -> ((Array with: repeatedObject) -> (40@50)).
	traveler := ObjectTraveler on: source.
	
	result := traveler findAllPathsTo: repeatedObject.

	result should haveSize: 2.
	result first should equalInOrder: { source key. source}.
	result last should equalInOrder: {  source value key. source value. source }.