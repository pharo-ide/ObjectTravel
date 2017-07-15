operations
collectReferences

	| result |
	result := OrderedCollection new.
	
	self referencesDo: [ :each | result add: each ].
	
	^result