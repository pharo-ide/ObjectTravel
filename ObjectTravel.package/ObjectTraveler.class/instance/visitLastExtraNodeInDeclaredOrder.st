private-navigation
visitLastExtraNodeInDeclaredOrder
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