/*:
 [⬅️](@previous) [➡️](@next)
 
 */
import Cocoa
/*:
 When you are working with optionals, you need to unwrap them, to get to the value inside.
 You can't do:

 `let sum = Optional.some(5) + 5`

 Swift is strongly typed language, and + function (yes, it is a function :)) takes two parameters of the **same** type.
 What we have here is:

 `let sum = Optional + Int`
 */
//: We have couple of options to unwrap optional values
let answer: Int? = 42
print("Optional value of 42")
dump(answer)
//: Unwrapped using **if let**
if let unwrapped = answer {
    print("Value of 42, using `if let x = optionalValue`")
    dump(unwrapped)
} else {
    print("There is no value!")
}
/*:
 Unwrapped using **guard let**

 - early return
 - on fail we will return immediately
 - on success, unwrapped value will be in scope after `guard`

 */
guard let unwrapped = answer else {
    fatalError("There is no value!") // or return in case you want to early return from function
}
print("Value of 42, using `guard let x = optionalValue else { return }`")
dump(unwrapped)
/*:
 Unwrapped using force unwrap **!**

 - You can use this when you are ABSOLUTELY sure that there is UNDERLYING VALUE (e.g. non `nil`)
 - You should avoid its usage as much as possible.
 - This will cause a runtime crash if there is no value
 */
print("Value of 42, using force unwrap `!`")
dump(answer!)
/*:
 Unwrapped using `??`
 - Basically you are saying, try unwrap this, and in case of `nil`, use this fallback value
 */
print("Value of 42, using `??`")
dump(answer ?? 5)
/*:
 > To recap:
 > - you would use **Optional** value when there is a chance that there will be **NO** value (e.g. nil, NULL, 0, -1, NSNotFound ...)
 > - Swift's way of handling nothingness.
 > - You want to model you code to use as few Optionals as possible. Why? Well you are adding a level of complexity with it.
 */
