operations
countReferences

	| count |
	count := 0.
	
	self referencesDo: [:each | count := count + 1 ].
	
	^count