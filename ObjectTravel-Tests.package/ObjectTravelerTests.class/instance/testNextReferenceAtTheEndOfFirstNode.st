tests
testNextReferenceAtTheEndOfFirstNode

	| traveler |
	traveler := ObjectTraveler on: (20@10 corner: 40@50).
	
	traveler nextReference; nextReference.
	traveler nextReference; nextReference.
	traveler currentReference should be: 10.	
	
	traveler nextReference should equal: 40