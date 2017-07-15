operations
skipAll: aCollection
	"Do not traverse all aCollection items.
	They could be only visited as sombody references without deep traversal"
	traversedObjects addAll: aCollection