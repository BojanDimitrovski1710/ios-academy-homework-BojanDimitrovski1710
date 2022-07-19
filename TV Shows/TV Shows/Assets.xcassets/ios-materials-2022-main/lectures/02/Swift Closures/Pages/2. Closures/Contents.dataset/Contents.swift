/*:
 [⬅️](@previous) [➡️](@next)

 */
import Cocoa
//:  ## CLOSURES
/*:

 > Closures are self-contained blocks of functionality that can be passed around and used in your code.
 > They are simillar to lambda functions or anonymous functions and are mostly used for **ASYNCHRONOUS** operations.

 */

//: Named **closure** with type signature `(Int) -> String`, meaning when called it will ask for **Int** and it will return **String**
let intToStringClosure = { (int: Int) -> String in
    return "\(int)"
}
intToStringClosure(4)
//: Named **function** with type signature `(Int) -> String`, as you can guess, this is pretty much the same as above...
func intToStringFunction(_ int: Int) -> String {
    return "\(int)"
}
intToStringFunction(4)
