tests
testTraverseArray

	| traveler |

	traveler := ObjectTraveler on: {1. 2. 3}.
	
	traveler nextReference should be: 1.
	traveler nextReference should be: 2.
	traveler nextReference should be: 3