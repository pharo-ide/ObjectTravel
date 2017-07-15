tests
testShouldNotTraverseSameObjectTwice

	| traveler repeatedObject |
	repeatedObject := 20@10.
	traveler := ObjectTraveler on: (repeatedObject -> (repeatedObject -> (40@50))).
	
	traveler nextReference; nextReference.
	traveler nextReference; nextReference. "20 and 10"
	
	traveler nextReference should equal: 20@10.		
	traveler nextReference should equal: 40@50.
	traveler nextReference should equal: 40.