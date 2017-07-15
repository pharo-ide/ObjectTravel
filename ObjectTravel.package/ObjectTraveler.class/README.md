I implement traversal of full object graph. I enumerate each reference in breadth-first direction and visit every reference only once. 

	traveler := ObjectTraveler on: 10@30.
	traveler moveToNextReference. "true".
	traveler currentReference. "10"
	traveler nextReference. "30"

	traveler := ObjectTraveler on: #(10 20 30).
	traveler nextReference "10"
	traveler nextReference "20" 

Also I can replace references with new values:

	traveler replaceCurrentReferenceWith:  #newReference.
 
    Instance Variables
	pathNodes:		<OrderedCollection>
	path:		<OrderedCollection of:  Integer>	
	traversedObjects:		<IdentitySet>
	nodesFilter:		<BlockClosure>
	forbiddenNodes:		<IdentitySet>

    Implementation Points

"pathNodes" contains currently discovered nodes of object graph. By default it is filled with root object. When I am moved in depth to new object I add it to end of pathNodes list. So  last item of pathNodes is currently discovered node in object graph.

"path" contains indexes of references which joint pathNodes items. For example if I have pathNodes={10@20} and path={2} then I point to object 20. If  I have pathNodes={(10@20) -> (30@40)} and path={2. 1} then I point to object 40.

"traversedObjects" contains all traversed nodes in objectGraph. I use it to ensure only once reference visiting.

"forbiddenNodes" is set of objects which should be not traversed inside object graph.

"nodesFilter" is predicate block which can be used to skip nodes in object graph.