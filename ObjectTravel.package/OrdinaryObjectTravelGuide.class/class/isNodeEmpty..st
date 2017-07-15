navigation
isNodeEmpty: anObject

	^(self classOf: anObject) instSize + (self sizeOf: anObject) = 0