/*:
 [⬅️](@previous) [➡️](@next)

 */
import Cocoa
/*:
 ## Capturing (closing over) semantics
 > Closures are types, and they are **REFERENCE** types.
 >
 > They can capture state (variables) from outer scope
 */
var number = 4
let addNumber = { (int: Int) -> Int in
    return number + int
}

number = 5
addNumber(5)

number = 10
addNumber(5)
