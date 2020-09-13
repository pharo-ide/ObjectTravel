"
I implement traversal of full object graph. I enumerate each reference in breadth-first direction and visit every reference only once. 

	traveler := ObjectTraveler on: 10@30.
	traveler moveToNextReference. ""true"".
	traveler currentReference. ""10""
	traveler nextReference. ""30""

	traveler := ObjectTraveler on: #(10 20 30).
	traveler nextReference ""10""
	traveler nextReference ""20"" 

Also I can replace references with new values:

	traveler replaceCurrentReferenceWith:  #newReference.
 
    Instance Variables
	pathNodes:		<OrderedCollection>
	path:		<OrderedCollection of:  Integer>	
	traversedObjects:		<IdentitySet>
	nodesFilter:		<BlockClosure>
	forbiddenNodes:		<IdentitySet>

    Implementation Points

""pathNodes"" contains currently discovered nodes of object graph. By default it is filled with root object. When I am moved in depth to new object I add it to end of pathNodes list. So  last item of pathNodes is currently discovered node in object graph.

""path"" contains indexes of references which joint pathNodes items. For example if I have pathNodes={10@20} and path={2} then I point to object 20. If  I have pathNodes={(10@20) -> (30@40)} and path={2. 1} then I point to object 40.

""traversedObjects"" contains all traversed nodes in objectGraph. I use it to ensure only once reference visiting.

""forbiddenNodes"" is set of objects which should be not traversed inside object graph.

""nodesFilter"" is predicate block which can be used to skip nodes in object graph.
"
Class {
	#name : #ObjectTraveler,
	#superclass : #Object,
	#instVars : [
		'pathNodes',
		'path',
		'traversedObjects',
		'nodesFilter',
		'currentReference',
		'currentNode',
		'currentReferenceIndex',
		'depthRouteForced',
		'leaveNodeAction'
	],
	#category : 'ObjectTravel'
}

{ #category : #'instance creation' }
ObjectTraveler class >> on: anObject [

	^self new
		startOn: anObject
]

{ #category : #'instance creation' }
ObjectTraveler class >> on: anObject where: nodesFilterBlock [

	^(self on: anObject)
		traverseOnly: nodesFilterBlock 
]

{ #category : #navigation }
ObjectTraveler >> alsoLookAt: anotherObject [
	self 
		deprecated: 'Use atNextStepVisit: instead'
	 	transformWith: '`@receiver alsoLookAt: `@statements1'
						-> '`@receiver atNextStepVisit: `@statements1'.
		
	self atNextStepVisit: anotherObject 
]

{ #category : #navigation }
ObjectTraveler >> atNextStepVisit: newObject [
	(self isNodeEmpty: newObject) ifTrue: [ ^self ].
	(self isTraversed: newObject) ifTrue: [ ^self ].
	traversedObjects add: newObject. 
	depthRouteForced | (currentReferenceIndex = 0) ifFalse: [ 
		depthRouteForced := true.	
		path atLast: 1 put: currentReferenceIndex negated.
		"Negative reference index or zero is special flag to catch that breadth way was interrupted 
		and traveler turn into depth direction of given extra node (newObject).
		When it will return breadth way will continue (look at #moveDepthToNextReference)"		
		pathNodes add: newObject.
		path add: 0. ^self].
	
	pathNodes add: newObject.
	path add: 0.
	self visitLastExtraNodeInDeclaredOrder. "it could be removed in future"
]

{ #category : #operations }
ObjectTraveler >> collectReferences [

	| result |
	result := OrderedCollection new.
	
	self referencesDo: [ :each | result add: each ].
	
	^result
]

{ #category : #operations }
ObjectTraveler >> copyObject [

	| activeNode copies nodeCopy copy startCopy |
	activeNode := currentNode.
	copies := IdentityDictionary new: 4096.
	copies at: currentNode put: (startCopy := nodeCopy := currentNode shallowCopy).
	
	[self moveToNextReference] whileTrue: [ 
		activeNode == currentNode ifFalse: [ 
			activeNode := currentNode.
			nodeCopy := copies at: activeNode.
		].
		copy := copies at: currentReference ifAbsentPut: [currentReference shallowCopy].	
			
		self replaceReferenceOf: nodeCopy at: currentReferenceIndex with: copy		
	 ].
	
	^startCopy
]

{ #category : #operations }
ObjectTraveler >> countReferences [

	| count |
	count := 0.
	
	self referencesDo: [:each | count := count + 1 ].
	
	^count
]

{ #category : #navigation }
ObjectTraveler >> currentNode [
	^currentNode
]

{ #category : #accessing }
ObjectTraveler >> currentNodeIndex [
	^pathNodes size
]

{ #category : #navigation }
ObjectTraveler >> currentReference [
	^currentReference
]

{ #category : #'private-navigation' }
ObjectTraveler >> currentReferenceIndex [
	^currentReferenceIndex
]

{ #category : #operations }
ObjectTraveler >> findAllPathsTo: anObject [

	| result |
	result := OrderedCollection new.
	self skip: self; skip: result.
	traversedObjects add: anObject.
	
	self referencesDo: [ :each |
		anObject == each ifTrue: [ result add: pathNodes reversed ]
	].

	^result
]

{ #category : #initialization }
ObjectTraveler >> initialize [

	super initialize.

	pathNodes := OrderedCollection new.
	path := OrderedCollection new.
	path add: 0.
	currentReferenceIndex := 0.
	traversedObjects := IdentitySet new.
	depthRouteForced := false
]

{ #category : #'private-testing' }
ObjectTraveler >> isAtLastReferenceOfCurrentNode [
	^ self
		isNode: currentNode
		hasLastReferenceAt: currentReferenceIndex
]

{ #category : #testing }
ObjectTraveler >> isAtStart [
	^currentReferenceIndex = 0
	
]

{ #category : #'private-testing' }
ObjectTraveler >> isCurrentReferenceEmpty [
	
	^self isNodeEmpty: currentReference 
]

{ #category : #'private-testing' }
ObjectTraveler >> isNode: anObject hasLastReferenceAt: referenceIndex [
	^anObject travelGuide isNode: anObject hasLastReferenceAt: referenceIndex
]

{ #category : #'private-testing' }
ObjectTraveler >> isNodeEmpty: anObject [
	
	^ anObject travelGuide isNodeEmpty: anObject
]

{ #category : #testing }
ObjectTraveler >> isTraversed: anObject [
	^(traversedObjects includes: anObject)
		or: [ nodesFilter notNil and: [(nodesFilter value: currentReference) not] ]
]

{ #category : #'private-navigation' }
ObjectTraveler >> moveBackInDepth [

	| leftNode |
	leftNode := pathNodes removeLast.
	path removeLast.
	currentNode := pathNodes last.
	currentReferenceIndex := path last.
	leaveNodeAction ifNotNil: [ leaveNodeAction value: leftNode ]
]

{ #category : #'private-navigation' }
ObjectTraveler >> moveBreadthToFirstReference [

	path atLast: 1 put: 1.
	currentReferenceIndex := 1.
	currentReference := self referenceOf: currentNode atIndex: currentReferenceIndex
]

{ #category : #'private-navigation' }
ObjectTraveler >> moveBreadthToNextReference [

	(self isAtLastReferenceOfCurrentNode) ifFalse: [ 
			currentReferenceIndex := currentReferenceIndex + 1.
			currentReference := self referenceOf: currentNode atIndex: currentReferenceIndex.
			path atLast: 1 put: currentReferenceIndex.	
			^true].

	path atLast: 1 put: currentReferenceIndex.
	^false
]

{ #category : #'private-navigation' }
ObjectTraveler >> moveDepthToNextReference [

	| newNode |
	[
		[self wantsTraverseCurrentReference not and: [self moveBreadthToNextReference]] whileTrue.
		path size = 1 or: [self wantsTraverseCurrentReference]
	] whileFalse: [ 
		self moveBackInDepth.
		(currentReferenceIndex <= 0) ifTrue: [ 
			"Depth way was forced by #atNextStepVisit: and now we need to continue walk breadth"
			currentReferenceIndex := currentReferenceIndex negated.
			path atLast: 1 put: currentReferenceIndex.
			^self moveToNextReference].
		self moveBreadthToNextReference
	 ].
			
	self wantsTraverseCurrentReference ifFalse: [ ^false].
	
	newNode := currentReference.
	pathNodes add: newNode.
	path add: 1.		
	traversedObjects add: newNode.
	currentNode := newNode.
	currentReferenceIndex := 1.
	currentReference := self referenceOf: currentNode atIndex: currentReferenceIndex.	
	^true
]

{ #category : #navigation }
ObjectTraveler >> moveToNextReference [
	(self isAtStart and: [self isNodeEmpty: currentNode ]) ifTrue: [ ^false ].		
	depthRouteForced ifTrue: [ 
		"It is special flag that traveler is forced to visit extra object in depth direction.
		Look at #atNextStepVisit:".
		depthRouteForced := false.
		currentNode := pathNodes last.
		currentReferenceIndex := 0 ]. 
	
	^self moveBreadthToNextReference or: [ 
			self moveBreadthToFirstReference.
			self moveDepthToNextReference]
]

{ #category : #navigation }
ObjectTraveler >> moveToNextReference: steps [
	steps timesRepeat: [ self moveToNextReference ifFalse: [ ^false ] ].
	
	^true
]

{ #category : #navigation }
ObjectTraveler >> nextReference [

	^self nextReferenceIfEnd: [ self error: 'travel is finished' ]
]

{ #category : #navigation }
ObjectTraveler >> nextReferenceIfEnd: endBlock [

	^self moveToNextReference ifTrue: [ currentReference  ] ifFalse: endBlock
]

{ #category : #accessing }
ObjectTraveler >> nodeAt: pathNodesIndex ifAbsent: absentBlock [

	^pathNodes at: pathNodesIndex ifAbsent: absentBlock 
]

{ #category : #accessing }
ObjectTraveler >> path [
	^ path
]

{ #category : #accessing }
ObjectTraveler >> path: anObject [
	path := anObject
]

{ #category : #accessing }
ObjectTraveler >> pathNodes [
	^ pathNodes
]

{ #category : #accessing }
ObjectTraveler >> pathNodes: anObject [
	pathNodes := anObject
]

{ #category : #'private-navigation' }
ObjectTraveler >> referenceOf: anObject atIndex: referenceIndex [
	
	^anObject travelGuide referenceOf: anObject atIndex: referenceIndex 
]

{ #category : #operations }
ObjectTraveler >> referencesDo: aBlock [

	[self moveToNextReference] whileTrue: [ 
		aBlock value: currentReference 
	]
]

{ #category : #operations }
ObjectTraveler >> referencesDo: aBlock until: conditionBlock [

	[self moveToNextReference and: [(conditionBlock value: currentReference) not]] whileTrue: [ 
		aBlock value: currentReference 
	]
]

{ #category : #operations }
ObjectTraveler >> replaceCurrentReferenceWith: anObject [
	
	self replaceReferenceOf: currentNode at: currentReferenceIndex with: anObject
]

{ #category : #'private-operations' }
ObjectTraveler >> replaceReferenceOf: anObject at: referenceIndex with: replacementObject [

	anObject travelGuide replaceReferenceOf: anObject at: referenceIndex with: replacementObject
]

{ #category : #operations }
ObjectTraveler >> skip: anObject [
	"Do not traverse given anObject. 
	It could be only visited as sombody reference without deep traversal"
	traversedObjects add: anObject
]

{ #category : #operations }
ObjectTraveler >> skipAll: aCollection [
	"Do not traverse all aCollection items.
	They could be only visited as sombody references without deep traversal"
	traversedObjects addAll: aCollection
]

{ #category : #navigation }
ObjectTraveler >> startNode [
	^pathNodes first
]

{ #category : #initialization }
ObjectTraveler >> startOn: anObject [

	pathNodes add: anObject.
	traversedObjects add: anObject.
	currentNode := anObject
]

{ #category : #operations }
ObjectTraveler >> traverseOnly: predicateBlock [
	
	nodesFilter := predicateBlock 
	
]

{ #category : #accessing }
ObjectTraveler >> traversedObjects [
	^ traversedObjects
]

{ #category : #accessing }
ObjectTraveler >> traversedObjects: anObject [
	traversedObjects := anObject
]

{ #category : #'private-navigation' }
ObjectTraveler >> visitLastExtraNodeInDeclaredOrder [
	| lastExtraNode previousRefIndex i |
	lastExtraNode := pathNodes last.
	
	previousRefIndex := 0.
	i := pathNodes size.
	[previousRefIndex = 0 ] whileTrue: [ 
		pathNodes at: i put: (pathNodes at: i - 1).
		i := i - 1.
		previousRefIndex := (i = 1 ifTrue: [ -1 ] ifFalse: [ path at: i - 1])
	].
	pathNodes at: i put: lastExtraNode
]

{ #category : #'private-testing' }
ObjectTraveler >> wantsTraverseCurrentReference [

	self isCurrentReferenceEmpty ifTrue: [ ^false ].
	
	^self isCurrentReferenceEmpty not and: [ (self isTraversed: currentReference) not ]
]

{ #category : #navigation }
ObjectTraveler >> whenLeaveNodeDo: actionBlockWithNode [
	leaveNodeAction := actionBlockWithNode
]
