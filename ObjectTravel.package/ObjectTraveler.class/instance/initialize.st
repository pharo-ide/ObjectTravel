initialization
initialize

	super initialize.

	pathNodes := OrderedCollection new.
	path := OrderedCollection new.
	path add: 0.
	currentReferenceIndex := 0.
	traversedObjects := IdentitySet new.
	depthRouteForced := false