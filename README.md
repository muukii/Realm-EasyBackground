# Realm-EasyBackground
[![CI Status](http://img.shields.io/travis/muukii/Realm-EasyBackground.svg?style=flat)](https://travis-ci.org/muukii/Realm-EasyBackground) [![Version](https://img.shields.io/cocoapods/v/Realm-EasyBackground.svg?style=flat)](http://cocoapods.org/pods/Realm-EasyBackground) [![License](https://img.shields.io/cocoapods/l/Realm-EasyBackground.svg?style=flat)](http://cocoapods.org/pods/Realm-EasyBackground) [![Platform](https://img.shields.io/cocoapods/p/Realm-EasyBackground.svg?style=flat)](http://cocoapods.org/pods/Realm-EasyBackground)

## Usage

```swift

import Realm_EasyBackground

let realm = try! Realm()

realm.writeBackground { realm in

    // Write on background thread
    let person = Person()
    try person.update(json)
    realm.add(person, update: true)
}
```

```swift

import Realm_EasyBackground

let realm = try! Realm()

realm.writeBackground ({ realm in

    // Write on background thread
    let person = Person()
    try person.update(json)
    realm.add(person, update: true)

},
completion { (error: ErrorType?) in

    // Callback on main thread
})
```

## Requirements
## Installation
Realm-EasyBackground is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod "Realm-EasyBackground"
```

## Author
muukii, m@muukii.me

## License
Realm-EasyBackground is available under the MIT license. See the LICENSE file for more info.
