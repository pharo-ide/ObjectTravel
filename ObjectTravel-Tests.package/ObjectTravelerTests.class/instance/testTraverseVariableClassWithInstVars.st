tests
testTraverseVariableClassWithInstVars

	| traveler |
	"WeakMessageSend instVarNames #(#selector #shouldBeNil #arguments)"
	traveler := ObjectTraveler on: (WeakMessageSend receiver: 1 selector: #abs arguments: #(3)).
	
	traveler nextReference should be: #abs.
	traveler nextReference. "shouldBeNil"
	traveler nextReference first should be: 3.
	traveler nextReference should be: 1.
	