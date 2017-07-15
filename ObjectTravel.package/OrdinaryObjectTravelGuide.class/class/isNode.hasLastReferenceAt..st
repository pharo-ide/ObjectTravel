navigation
isNode: anObject hasLastReferenceAt: referenceIndex

	^referenceIndex >= ((self classOf: anObject) instSize + (self sizeOf: anObject))