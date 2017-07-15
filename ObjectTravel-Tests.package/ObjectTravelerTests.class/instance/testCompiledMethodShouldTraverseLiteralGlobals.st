tests
testCompiledMethodShouldTraverseLiteralGlobals
	| traveler refs |
	(Point >> #extent:) literals. "{#Rectangle->Rectangle. #origin:extent:. #extent:. #Point->Point} "
	
	traveler := ObjectTraveler on: Point >> #extent:.
	traveler skipAll: {Rectangle superclass. Rectangle methodDictionary. Rectangle environment. Point}.
	traveler skipAll: Rectangle subclasses.
	
	refs := traveler collectReferences.
	refs should include: Rectangle