tests
testShouldNotTraverseSourceObjectTwice

	| traveler source |
	source := (20@10 -> (#toReplace -> (40@50))).
	source value key: source.
	traveler := ObjectTraveler on: source.
	
	traveler nextReference; nextReference.
	traveler nextReference; nextReference. "20 and 10"
	
	traveler nextReference should be: source.		
	traveler nextReference should equal: 40@50.
	traveler nextReference should equal: 40.