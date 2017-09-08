## Getting Started

### Useful Links
- https://realm.io/docs/swift/latest/
- https://github.com/jakenberg/ObjectMapper-Realm
- https://github.com/APUtils/ObjectMapperAdditions#realm-features
- https://github.com/Hearst-DD/ObjectMapper
- https://realm.io/docs/tutorials/realmtasks/

### Pre-downloads
- Realm Browser
- https://itunes.apple.com/app/realm-browser/id1007457278

### Pods
```
pod 'RealmSwift'
pod 'ObjectMapper'
pod 'ObjectMapper+Realm'
```

### Realm 101
- not all property can be optional
- primary key
- index properties
 - optimizing read performance
 - slower write  
- Ignoring properties
 - field in same model class but doesn't needs to be saved (eg. Computed values)
 - migration is needed
 - [sync realm over different devices](https://realm.io/docs/swift/latest/#opening-a-synchronized-realm)
 - [viewing db on device/simulator](https://stackoverflow.com/questions/28465706/how-to-find-my-realm-file)


### Models
#### ObjectMapper
ObjectMapper Object can be both optional and non-optional.

```
class User: Mappable {
  var name: String?
  var age: Int?

  required init?(map: Map) {}

  func mapping(map: Map) {
    name <- map["name"]
    age <- map["age"]
  }
}
```

```
struct User: Mappable {
  var name: String?
  var age: Int?

  // use to create object, use to validate JSOn before object serialization. Return nil will prevent object creation.
  init?(map: Map) {}

  // use to generate JSON objects
  mutating func mapping(map: Map) {
    name <- map["name"]
    age <- map["age"]
  }
}
```

#### Realm
Realm parses all models defined in your code at launch, they must all be valid, even if they are never used.

```
class User: Object {
  dynamic var name = ""
  dynamic var age = 0

  dynamic var id = ""

  // optional
  override static func primarykey() -> String? {
    return "id"
  }
}
```
* Declaring a primary key allows objects to be looked up and updated efficiently and enforces uniqueness for each value. Once an object with a primary key is added to a Realm, the primary key cannot be changed.

### Supported Properties Types

#### Object Mapper
```
Int, Bool, Double, Float, String
RawRepresentable (Enums)
Array<Any>
Dictionary<String, Any>
Object<T: Mappable>
Array<T: Mappable>
Array<Array<T: Mappable>>
Set<T: Mappable>
Dictionary<String, T: Mappable>
Dictionary<String, Array<T: Mappable>>
```
* supports Optionals of all the above and Implicitly Unwrapped Optionals of the above

#### Realm
```
Bool, Int, Int8, Int16, Int32, Int64, Double, Float, String, Date, Data, Object
```

Can be Optional:
```
String, Date, Data
```

Must be Optional:
```
Object
```

RealmOptional:
```
Optional numeric types: let aIntValue = RealmOptional<Int>()

Int, Float, Double, Bool, and all of the sized versions of Int (Int8, Int16, Int32, Int64)
```
*CGFloat properties are discouraged, as the type is not platform independent.


### Converting to each other
