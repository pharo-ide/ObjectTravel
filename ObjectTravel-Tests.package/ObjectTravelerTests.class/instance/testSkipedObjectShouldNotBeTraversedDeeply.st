tests
testSkipedObjectShouldNotBeTraversedDeeply

	| traveler skipedObject |
	skipedObject := 20@10.
	traveler := ObjectTraveler on: skipedObject ->(40@50).
	traveler skip: skipedObject.
		
	traveler nextReference should be: skipedObject.
	traveler nextReference should equal: (40@50).
	traveler nextReference should equal: 40.
	traveler nextReference should equal: 50