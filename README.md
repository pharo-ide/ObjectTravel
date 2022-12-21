# ObjectTravel

[![GitHub release](https://img.shields.io/github/release/pharo-ide/ObjectTravel.svg)](https://github.com/pharo-ide/ObjectTravel/releases/latest)
[![Unit Tests](https://github.com/pharo-ide/ObjectTravel/actions/workflows/tests.yml/badge.svg)](https://github.com/pharo-ide/ObjectTravel/actions/workflows/tests.yml)

[![Pharo 7.0](https://img.shields.io/badge/Pharo-7.0-informational)](https://pharo.org)
[![Pharo 8.0](https://img.shields.io/badge/Pharo-8.0-informational)](https://pharo.org)
[![Pharo 9.0](https://img.shields.io/badge/Pharo-9.0-informational)](https://pharo.org)
[![Pharo 10](https://img.shields.io/badge/Pharo-10-informational)](https://pharo.org)
[![Pharo 11](https://img.shields.io/badge/Pharo-11-informational)](https://pharo.org)

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
  repository: 'github://pharo-ide/ObjectTravel';
  load
```
Use following snippet for stable dependency in your project baseline:
```Smalltalk
spec
    baseline: 'ObjectTravel'
    with: [ spec repository: 'github://pharo-ide/ObjectTravel:v1.0.0' ]
```
