tests
testShouldSkipSymbolsStructure

	| traveler |
	"WeakMessageSend instVarNames #(#selector #shouldBeNil #arguments)"
	traveler := ObjectTraveler on: #(#abs #(2 3)).
	
	traveler nextReference should be: #abs.
	traveler nextReference should equal: #(2 3).
	traveler nextReference should be: 2.