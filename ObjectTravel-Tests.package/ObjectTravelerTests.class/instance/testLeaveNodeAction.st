tests
testLeaveNodeAction

	| traversed traveler leftNodes |
	traversed := OrderedCollection new.
	leftNodes := OrderedCollection new.
	traveler := ObjectTraveler on: (10@20 corner: 30@40).
	traveler whenLeaveNodeDo: [ :node | leftNodes add: node ].
	
	traveler referencesDo: [:each | traversed add: each].
	traversed should equalInOrder: {10@20. 30@40. 10. 20. 30. 40}.
	leftNodes should equalInOrder: {10@20. 30@40 }