tests
testLeaveNodeActionWhenExtraNodeLeft

	| traveler leftNodes |
	leftNodes := OrderedCollection new.
	traveler := ObjectTraveler on: {10@20. 30@40. 50@60}.
	traveler whenLeaveNodeDo: [ :node | leftNodes add: node ].

	traveler referencesDo: [:each | each = (30@40) ifTrue: [traveler atNextStepVisit: 70@80]].
		
	leftNodes should equalInOrder: {70@80. 10@20. 30@40. 50@60 }