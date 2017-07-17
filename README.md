# ObjectTravel
Object traveler is a tool to traverse full object graph. It allows enumerate each reference of given object in breadth-first direction and visit every reference only once.

```Smalltalk
traveler := ObjectTraveler on: 10@30.
traveler moveToNextReference. "true".
traveler currentReference. "10"
traveler nextReference. "30"
```
```Smalltalk
traveler := ObjectTraveler on: #(10 20 30).
traveler nextReference "10"
traveler nextReference "20"
```
## Installation
```Smalltalk
Metacello new
  baseline: 'ObjectTravel';
  repository: 'github://dionisiydk/ObjectTravel';
  load
```
Use following snippet for stable dependency in your project baseline:
```Smalltalk
spec
    baseline: 'ObjectTravel'
    with: [ spec repository: 'github://dionisiydk/ObjectTravel:v0.6.x' ]
```