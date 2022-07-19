/*:
 [⬅️](@previous) [➡️](@next)

 */
import Cocoa
/*:
 ### Value Type vs. Reference Type

 >  **Class** -> Reference Type
 >
 > **Struct** -> Value Type

 - value types will always copy their value while reference types will not.
 - almost all of the types in Swift are Value Types, only Classes are Reference Types
 - arrays, dictionaries, numbers, booleans, tuples and enums are **value types**
 - [read more here](https://docs.swift.org/swift-book/LanguageGuide/ClassesAndStructures.html)

 *Rule of thumb*
 - reference types can have behavior
 - value types are inert - data model
 */
//: ## Value Type
struct PointStruct {
    var x: Int
    var y: Int
}

var structPoint = PointStruct(x: 1, y: 2)
var sameStructPoint = structPoint
sameStructPoint.x = 3

print("structPoint: \(structPoint)")
print("sameStructPoint: \(sameStructPoint)")
// TODO: Try to make sameStructPoint as let constant - what will happen?

//: ## Reference Type
final class PointClass {
    var x: Int
    var y: Int
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}

var classPoint = PointClass(x: 1, y: 2)
var sameClassPoint = classPoint
sameClassPoint.x = 3

print("classPoint:")
dump(classPoint)
print("sameClassPoint:")
dump(sameClassPoint)
