/*:
 [⬅️](@previous) [➡️](@next)

 */
import Cocoa
/*:
 ## Capturing Values

 When capturing (closing over) VALUE types, VALUE will not be captured on the creation, but rather when you actually
 call the closure, this is default behavior.

 However, there is an option to actually capture the value on creation, with something called `capture list`,
 this will not be shown here for now :)

 */

var a = 10
let b = {
    // When you see somethig like this, and you are not sure about closure type, use ALT + click on variable to get info
    // In this case, we have `let b: () -> ()`, so we know that this is a closure that takes nothing and doesn't return nothing.
    print(a)
    a += 5
}

a += 10
b()

a += 10
b()
