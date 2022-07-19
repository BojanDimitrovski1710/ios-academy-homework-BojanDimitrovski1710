/*:
 [⬅️](@previous) [➡️](@next)

 */
import Cocoa
/*:
 ### `let` vs. `var`
 
- You should usually use `let` as much as possible.
- Why?
    - It is much easier to reason about the code when you know that value can't be changed once set.
    - We will talk about this more ...
    - If you want to know more, google `referential transparency`
 */
//: `Int`, immutable, with type inference, there is no need to declare type
let immutableNumber = 42
//: Compile time error, `number` is a constant, try uncommenting
// immutableNumber = 43

var mutableNumber = 42 // Int
mutableNumber = 43 // This is ok, as `mutableNumber` is a variable, not a constant

print(immutableNumber)
print(mutableNumber)
