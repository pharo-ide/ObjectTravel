operations
findAllPathsTo: anObject

	| result |
	result := OrderedCollection new.
	self skip: self; skip: result.
	traversedObjects add: anObject.
	
	self referencesDo: [ :each |
		anObject == each ifTrue: [ result add: pathNodes reversed ]
	].

	^result