Class {
	#name : #ObjectTravelerTests,
	#superclass : #TestCase,
	#category : 'ObjectTravel-Tests'
}

{ #category : #tests }
ObjectTravelerTests >> testCollectingRefereces [

	| traveler actual |
	traveler := ObjectTraveler on: {10@20. 30@50}.
	
	actual := traveler collectReferences.

	actual should equal: { 10@20. 30@50. 10. 20. 30. 50 }
]

{ #category : #tests }
ObjectTravelerTests >> testCompiledMethodShouldTraverseLiteralGlobals [
	| traveler refs |
	(Point >> #extent:) literals. "{#Rectangle->Rectangle. #origin:extent:. #extent:. #Point->Point} "
	
	traveler := ObjectTraveler on: Point >> #extent:.
	traveler skipAll: {Rectangle superclass. Rectangle methodDictionary. Rectangle environment. Point}.
	traveler skipAll: Rectangle subclasses.
	
	refs := traveler collectReferences.
	refs should include: Rectangle
]

{ #category : #tests }
ObjectTravelerTests >> testCompiledMethodShouldTraverseLiterals [
	| traveler |
	(Point >> #extent:) literals. "{#Rectangle->Rectangle. #origin:extent:. #extent:. #Point->Point} "
	
	traveler := ObjectTraveler on: Point >> #extent:.
	traveler traverseOnly: [ :each | (each isKindOf: Class) not ].

	traveler countReferences should equal: 8 "4 literals + 2 keys and 2 values from global variables"
]

{ #category : #tests }
ObjectTravelerTests >> testCopyObject [

	| traveler repeatedObject source copy |
	repeatedObject := 20@10.
	source := repeatedObject -> (repeatedObject -> (40@50)).
	traveler := ObjectTraveler on: source.
	
	copy := traveler copyObject.

	copy key should not be: source key.
	copy value key should be: copy key.
	copy value value should not be: 40@50.
	copy value value should equal: 40@50.
]

{ #category : #tests }
ObjectTravelerTests >> testCountingRefereces [

	| traveler actual |
	traveler := ObjectTraveler on: 10@20.
	
	actual := traveler countReferences.

	actual should be: 2
]

{ #category : #tests }
ObjectTravelerTests >> testCountingReferecesWhenGraphWithLoops [

	| traveler repeatedObject source actual |
	repeatedObject := 20@10.
	source := repeatedObject -> (repeatedObject -> 40).
	traveler := ObjectTraveler on: source.
	
	actual := traveler countReferences.

	actual should be: 6
]

{ #category : #tests }
ObjectTravelerTests >> testFindingAllPathToParticularObject [

	| traveler repeatedObject source result |
	repeatedObject := 20@10.
	source := (0 -> repeatedObject) -> ((Array with: repeatedObject) -> (40@50)).
	traveler := ObjectTraveler on: source.
	
	result := traveler findAllPathsTo: repeatedObject.

	result should haveSize: 2.
	result first should equalInOrder: { source key. source}.
	result last should equalInOrder: {  source value key. source value. source }.
]

{ #category : #tests }
ObjectTravelerTests >> testGettingStartNode [

	| traveler actual |
	traveler := ObjectTraveler on: #start.
	
	actual := traveler startNode.

	actual should be: #start
]

{ #category : #tests }
ObjectTravelerTests >> testIsAtEndWhenLastReferenceIsAlreadyTraversed [

	| traveler repeatedObject |
	repeatedObject := 20@10.
	traveler := ObjectTraveler on: (repeatedObject -> repeatedObject).
	
	traveler nextReference; nextReference.
	traveler nextReference; nextReference. "20 and 10"
	
	traveler moveToNextReference should be: false
]

{ #category : #tests }
ObjectTravelerTests >> testIsAtEndWhenNoReferenceAnymore [

	| traveler |
	traveler := ObjectTraveler on: 20@10.
	
	traveler nextReference; nextReference.

	traveler moveToNextReference should be: false
]

{ #category : #tests }
ObjectTravelerTests >> testLeaveNodeAction [

	| traversed traveler leftNodes |
	traversed := OrderedCollection new.
	leftNodes := OrderedCollection new.
	traveler := ObjectTraveler on: (10@20 corner: 30@40).
	traveler whenLeaveNodeDo: [ :node | leftNodes add: node ].
	
	traveler referencesDo: [:each | traversed add: each].
	traversed should equalInOrder: {10@20. 30@40. 10. 20. 30. 40}.
	leftNodes should equalInOrder: {10@20. 30@40 }
]

{ #category : #tests }
ObjectTravelerTests >> testLeaveNodeActionWhenExtraNodeLeft [

	| traveler leftNodes |
	leftNodes := OrderedCollection new.
	traveler := ObjectTraveler on: {10@20. 30@40. 50@60}.
	traveler whenLeaveNodeDo: [ :node | leftNodes add: node ].

	traveler referencesDo: [:each | each = (30@40) ifTrue: [traveler atNextStepVisit: 70@80]].
		
	leftNodes should equalInOrder: {70@80. 10@20. 30@40. 50@60 }
]

{ #category : #tests }
ObjectTravelerTests >> testNextReferenceAtTheEndOfFirstNode [

	| traveler |
	traveler := ObjectTraveler on: (20@10 corner: 40@50).
	
	traveler nextReference; nextReference.
	traveler nextReference; nextReference.
	traveler currentReference should be: 10.	
	
	traveler nextReference should equal: 40
]

{ #category : #tests }
ObjectTravelerTests >> testNextReferenceAtTheStart [

	| traveler |
	traveler := ObjectTraveler on: 20@10.
	
	traveler nextReference should equal: 20
]

{ #category : #tests }
ObjectTravelerTests >> testNextReferenceInDepth [

	| traveler |
	traveler := ObjectTraveler on: (20@10 corner: 40@50).
	
	traveler nextReference; nextReference.
	
	traveler nextReference should equal: 20
]

{ #category : #tests }
ObjectTravelerTests >> testNextReferenceOnEmptyObject [

	| traveler |
	traveler := ObjectTraveler on: Object new.
	
	traveler moveToNextReference should be: false
]

{ #category : #tests }
ObjectTravelerTests >> testReferencesEnumeration [

	| traversed traveler |
	traversed := OrderedCollection new.
	traveler := ObjectTraveler on: 10@20.
	
	traveler referencesDo: [:each | traversed add: each].

	traversed should equal: #(10 20)
]

{ #category : #tests }
ObjectTravelerTests >> testReferencesEnumerationWhenGraphWithLoops [

	| traversed traveler repeatedObject source |
	traversed := OrderedCollection new.
	repeatedObject := 20@10.
	source := repeatedObject -> (repeatedObject -> 40).
	traveler := ObjectTraveler on: source.
	
	traveler referencesDo: [:each | traversed add: each].

	traversed should equal: {repeatedObject. source value. 20. 10. repeatedObject. 40}
]

{ #category : #tests }
ObjectTravelerTests >> testReplacingReference [

	| traveler repeatedObject source |
	repeatedObject := 20@10.
	source := repeatedObject -> (repeatedObject -> (40@50)).
	traveler := ObjectTraveler on: source.
	
	traveler nextReference should be: repeatedObject.
	traveler replaceCurrentReferenceWith: #newReference.
	
	source key should be: #newReference.
	source value key should be: repeatedObject 
]

{ #category : #tests }
ObjectTravelerTests >> testReplacingReferenceInArray [

	| traveler source |
	source := #(1 2 3) copy.
	traveler := ObjectTraveler on: source.
	
	traveler moveToNextReference: 2.
	traveler currentReference should be: 2.
	traveler replaceCurrentReferenceWith: #newReference.
	
	source should equal: #(1 #newReference 3)
]

{ #category : #tests }
ObjectTravelerTests >> testReplacingReferenceInVariableClassWithInstVars [

	| traveler source |
	source := WeakMessageSend receiver: 1 selector: #abs.
	traveler := ObjectTraveler on: source.
	
	traveler moveToNextReference.
	traveler currentReference should be: #abs.
	traveler replaceCurrentReferenceWith: #newSelector.

	traveler moveToNextReference; moveToNextReference; moveToNextReference.
	traveler currentReference should be: 1.
	traveler replaceCurrentReferenceWith: #newReceiver.
	
	source receiver should be: #newReceiver.
	source selector should be: #newSelector
]

{ #category : #tests }
ObjectTravelerTests >> testReplacingReferenceWhenExtraNodeVisitingIsPlanned [

	| traveler source |
	source := {1@3. 2@3}.
	traveler := ObjectTraveler on: source.
	
	traveler nextReference should equal: 1@3.
	traveler atNextStepVisit: 4@5.
	traveler replaceCurrentReferenceWith: 6@7.
	
	source first should equal: 6@7.
	traveler nextReference should equal: 4.
]

{ #category : #tests }
ObjectTravelerTests >> testShouldNotTraverseSameObjectTwice [

	| traveler repeatedObject |
	repeatedObject := 20@10.
	traveler := ObjectTraveler on: (repeatedObject -> (repeatedObject -> (40@50))).
	
	traveler nextReference; nextReference.
	traveler nextReference; nextReference. "20 and 10"
	
	traveler nextReference should equal: 20@10.		
	traveler nextReference should equal: 40@50.
	traveler nextReference should equal: 40.
]

{ #category : #tests }
ObjectTravelerTests >> testShouldNotTraverseSourceObjectTwice [

	| traveler source |
	source := (20@10 -> (#toReplace -> (40@50))).
	source value key: source.
	traveler := ObjectTraveler on: source.
	
	traveler nextReference; nextReference.
	traveler nextReference; nextReference. "20 and 10"
	
	traveler nextReference should be: source.		
	traveler nextReference should equal: 40@50.
	traveler nextReference should equal: 40.
]

{ #category : #tests }
ObjectTravelerTests >> testShouldSkipSymbolsStructure [

	| traveler |
	"WeakMessageSend instVarNames #(#selector #shouldBeNil #arguments)"
	traveler := ObjectTraveler on: #(#abs #(2 3)).
	
	traveler nextReference should be: #abs.
	traveler nextReference should equal: #(2 3).
	traveler nextReference should be: 2.
]

{ #category : #tests }
ObjectTravelerTests >> testSkipedObjectShouldNotBeTraversedDeeply [

	| traveler skipedObject |
	skipedObject := 20@10.
	traveler := ObjectTraveler on: skipedObject ->(40@50).
	traveler skip: skipedObject.
		
	traveler nextReference should be: skipedObject.
	traveler nextReference should equal: (40@50).
	traveler nextReference should equal: 40.
	traveler nextReference should equal: 50
]

{ #category : #tests }
ObjectTravelerTests >> testTraverseArray [

	| traveler |

	traveler := ObjectTraveler on: {1. 2. 3}.
	
	traveler nextReference should be: 1.
	traveler nextReference should be: 2.
	traveler nextReference should be: 3
]

{ #category : #tests }
ObjectTravelerTests >> testTraverseBlockClosure [

	| traveler block refs |
	block := [Point x: 1 y: 10].
	traveler := ObjectTraveler on: block.
	traveler skipAll: {
		block outerContext sender. traveler. traveler class. self class. Point. Identical}.

	refs := traveler collectReferences.
	refs should include: block outerContext.
	refs should include: (Identical to: block).
	refs should include: thisContext method.
	refs should include: self.
	refs size should be < 42
]

{ #category : #tests }
ObjectTravelerTests >> testTraverseObjectWhereFirstDeepReferenceIsSkipped [

	| traveler nodeToSkip |
	nodeToSkip := {2. 3}.
	traveler := ObjectTraveler on: {{nodeToSkip. 4}}.
	traveler skip: nodeToSkip.

	traveler collectReferences should equal: {{nodeToSkip. 4 }. nodeToSkip. 4 }.
]

{ #category : #tests }
ObjectTravelerTests >> testTraverseOnlyFilteredNodes [

	| traveler nodeToSkip  |
	nodeToSkip := 10@20.
	traveler := ObjectTraveler on: (nodeToSkip corner: 40@50) where: [ :node | node ~= nodeToSkip ].
	
	traveler collectReferences should equal: {nodeToSkip. 40@50. 40. 50}.
]

{ #category : #tests }
ObjectTravelerTests >> testTraverseOnlyFilteredNodes2 [

	| traveler rect |
	rect := 1@2 corner: 3@4.
	traveler := ObjectTraveler on: {rect. 5@6} where: [ :node | node isKindOf: Point ].

	traveler collectReferences should equal: {rect. 5@6. 5. 6}.
]

{ #category : #tests }
ObjectTravelerTests >> testTraverseVariableClassWithInstVars [

	| traveler |
	"WeakMessageSend instVarNames #(#selector #shouldBeNil #arguments)"
	traveler := ObjectTraveler on: (WeakMessageSend receiver: 1 selector: #abs arguments: #(3)).
	
	traveler nextReference should be: #abs.
	traveler nextReference. "shouldBeNil"
	traveler nextReference first should be: 3.
	traveler nextReference should be: 1.
	
]

{ #category : #tests }
ObjectTravelerTests >> testVisitingExtaNodeAtEndOfExistingNodeWhenFirstIsSkipped [

	| traveler nodes source |
	source := {1@2. 3@4}.
	traveler := ObjectTraveler on: source.
	traveler skip: source first.
	
	nodes := OrderedCollection new.

	traveler referencesDo: [:each | each = (3@4) ifTrue: [traveler atNextStepVisit: 8@9].
		nodes add: each ].

	nodes should equalInOrder: {1@2. 3@4. 8. 9. 3. 4}
]

{ #category : #tests }
ObjectTravelerTests >> testVisitingExtraEmptyNode [

	| traveler nodes |
	traveler := ObjectTraveler on: {1@2. 3@4. 5@6}.
	
	nodes := OrderedCollection new.
	
	traveler referencesDo: [:each | each = (3@4) ifTrue: [traveler atNextStepVisit: Object new].
		nodes add: each ].

	nodes should equalInOrder: {1@2. 3@4. 5@6. 1. 2. 3. 4. 5. 6}
]

{ #category : #tests }
ObjectTravelerTests >> testVisitingExtraNode [

	| traveler nodes |
	traveler := ObjectTraveler on: {1@2. 3@4. 5@6}.
	
	nodes := OrderedCollection new.
	
	traveler referencesDo: [:each | each = (3@4) ifTrue: [traveler atNextStepVisit: 8@9].
		nodes add: each ].

	nodes should equalInOrder: {1@2. 3@4. 8. 9. 5@6. 1. 2. 3. 4. 5. 6}
]

{ #category : #tests }
ObjectTravelerTests >> testVisitingExtraNodeAtEndOfExistingNode [

	| traveler nodes |
	traveler := ObjectTraveler on: {1@2. 3@4}.
	
	nodes := OrderedCollection new.

	traveler referencesDo: [:each | each = (3@4) ifTrue: [traveler atNextStepVisit: 8@9].
		nodes add: each ].

	nodes should equalInOrder: {1@2. 3@4. 8. 9. 1. 2. 3. 4}
]

{ #category : #tests }
ObjectTravelerTests >> testVisitingExtraNodeInsideAnotherExtraNode [

	| traveler nodes source |
	source := {1@2. 3@4. 5@6}.
	traveler := ObjectTraveler on: source.
	
	nodes := OrderedCollection new.

	traveler referencesDo: [:each | 
		each = (3@4) ifTrue: [traveler atNextStepVisit: {7@8. 9@10}].
		each = (9@10) ifTrue: [ traveler atNextStepVisit: 11@12 ].
		nodes add: each ].

	nodes should equalInOrder: {1@2. 3@4. 7@8. 9@10. 11. 12. 7. 8. 9. 10. 5@6. 1. 2. 3. 4. 5. 6}
]

{ #category : #tests }
ObjectTravelerTests >> testVisitingExtraNodeShouldNotChangeCurrentNodeAndReference [

	| traveler root |
	root := {1@2. 3@4. 5@6}.
	traveler := ObjectTraveler on: root.
	
	traveler moveToNextReference; moveToNextReference.
	
	traveler currentNode should be: root.
	traveler currentReference should equal: 3@4.
	
	traveler atNextStepVisit: 8@9.
	
	traveler currentNode should be: root.
	traveler currentReference should equal: 3@4
]

{ #category : #tests }
ObjectTravelerTests >> testVisitingExtraNodeTwice [
	| traversed traveler anotherObject |
	traversed := OrderedCollection new.
	traveler := ObjectTraveler on: 10 @ 20.
	anotherObject := 30 @ 50.
	
	traveler referencesDo: [ :each | 
			traversed add: each.
			each = 10 ifTrue: [
				traveler atNextStepVisit: anotherObject; atNextStepVisit: anotherObject]].
		
	traversed should equal: {10 . 20 . 30 . 50}
]

{ #category : #tests }
ObjectTravelerTests >> testVisitingExtraNodeWhenItIsForcedBeforeEnumeration [

	| traveler nodes |
	traveler := ObjectTraveler on: {1@2. 3@4. 5@6}.
	traveler atNextStepVisit: 7@8.
	
	nodes := OrderedCollection new.
	
	traveler referencesDo: [:each | nodes add: each ].

	nodes should equalInOrder: {1@2. 3@4. 5@6. 1. 2. 3. 4. 5. 6. 7. 8}
]

{ #category : #tests }
ObjectTravelerTests >> testVisitingExtraNodeWhichWasAlreadyTraversed [
	| traversed traveler anotherObject |
	traversed := OrderedCollection new.
	traveler := ObjectTraveler on: 10 @ 20.
	anotherObject := 30 @ 50.
	traveler skip: anotherObject.
	
	traveler referencesDo: [ :each | 
			traversed add: each.
			each = 10 ifTrue: [traveler atNextStepVisit: anotherObject]].
		
	traversed should equal: {10 . 20}
]

{ #category : #tests }
ObjectTravelerTests >> testVisitingThreeExtraNodes [

	| traveler nodes |
	traveler := ObjectTraveler on: {1@2. 3@4. 5@6}.
	
	nodes := OrderedCollection new.
	
	traveler referencesDo: [:each | each = (3@4) ifTrue: [
			traveler atNextStepVisit: 8@9; atNextStepVisit: 10@11; atNextStepVisit: 12@13].
		nodes add: each ].

	nodes should equalInOrder: {1@2. 3@4. 8. 9. 10. 11. 12. 13. 5@6. 1. 2. 3. 4. 5. 6}
]

{ #category : #tests }
ObjectTravelerTests >> testVisitingThreeExtraNodesWhereLastTwoAreSame [
	| traversed traveler anotherObject |
	traversed := OrderedCollection new.
	traveler := ObjectTraveler on: 10 @ 20.
	anotherObject := 30 @ 50.
	
	traveler referencesDo: [ :each | 
			traversed add: each.
			each = 10 ifTrue: [
				traveler 	
					atNextStepVisit: 5@6;
					atNextStepVisit: anotherObject; atNextStepVisit: anotherObject]].
		
	traversed should equal: {10 . 20 . 5.  6.  30 . 50}
]

{ #category : #tests }
ObjectTravelerTests >> testVisitingTwoExtraNodes [

	| traveler nodes |
	traveler := ObjectTraveler on: {1@2. 3@4. 5@6}.
	
	nodes := OrderedCollection new.
	
	traveler referencesDo: [:each | each = (3@4) ifTrue: [
			traveler atNextStepVisit: 8@9; atNextStepVisit: 10@11].
		nodes add: each ].

	nodes should equalInOrder: {1@2. 3@4. 8. 9. 10. 11. 5@6. 1. 2. 3. 4. 5. 6}
]
