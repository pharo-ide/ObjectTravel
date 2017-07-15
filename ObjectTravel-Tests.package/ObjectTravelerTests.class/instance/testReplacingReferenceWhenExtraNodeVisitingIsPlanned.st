tests
testReplacingReferenceWhenExtraNodeVisitingIsPlanned

	| traveler source |
	source := {1@3. 2@3}.
	traveler := ObjectTraveler on: source.
	
	traveler nextReference should equal: 1@3.
	traveler atNextStepVisit: 4@5.
	traveler replaceCurrentReferenceWith: 6@7.
	
	source first should equal: 6@7.
	traveler nextReference should equal: 4.