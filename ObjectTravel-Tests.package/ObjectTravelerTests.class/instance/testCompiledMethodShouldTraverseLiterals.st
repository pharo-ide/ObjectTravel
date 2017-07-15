tests
testCompiledMethodShouldTraverseLiterals
	| traveler |
	(Point >> #extent:) literals. "{#Rectangle->Rectangle. #origin:extent:. #extent:. #Point->Point} "
	
	traveler := ObjectTraveler on: Point >> #extent:.
	traveler traverseOnly: [ :each | (each isKindOf: Class) not ].

	traveler countReferences should equal: 8 "4 literals + 2 keys and 2 values from global variables"