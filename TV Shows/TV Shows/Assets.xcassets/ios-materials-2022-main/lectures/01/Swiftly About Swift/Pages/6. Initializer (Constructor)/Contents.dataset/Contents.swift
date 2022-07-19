/*:
 [⬅️](@previous) [➡️](@next)

 */
import Cocoa
/*:
 Initializer

 - same as constructor in C++/Java. Each type has it: class, struct, enum
 - special methods that can be called to create a new instance of a particular type
 - setting an initial value for each stored property on that instance
 - [read more here](https://docs.swift.org/swift-book/LanguageGuide/Initialization.html)
 */

class MyClass1 {

    var variable0: Int  // must be initialized during `init` call
    let variable1: Int  // must be initialized during `init` call
    var variable2: Int? // no need to initialized, nil by default
    var variable3: Int? // no need to initialized, nil by default

    // You can pass default value, that way you can omit some values while calling init
    init(variable0: Int, variable1: Int, variable2: Int = 4, variable3: Int?) {
        self.variable0 = variable0
        self.variable1 = variable1
        self.variable2 = variable2
        self.variable3 = variable3
    }
}
//: Usage
let someObject1 = MyClass1(variable0: 0, variable1: 1, variable3: 3)
let someObject2 = MyClass1(variable0: 0, variable1: 1, variable3: nil)
let someObject3 = MyClass1(variable0: 0, variable1: 1, variable2: 2, variable3: 3)

dump(someObject1)
dump(someObject2)
dump(someObject3)
