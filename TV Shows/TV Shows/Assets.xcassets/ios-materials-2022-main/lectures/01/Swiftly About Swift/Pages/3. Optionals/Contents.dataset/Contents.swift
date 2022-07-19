/*:
 [⬅️](@previous) [➡️](@next)

 */
import Cocoa
/*:
 ### Optional

 - Optional is a **type**. More specifically an **enum**.

 So when reading this:
 - it **doesn't** say this is an **Int** which is **optional**.
 - it **does** say this is an **Optional** which may or may not contain a value of type **Int**

 When creating a class or a struct:
 - you can either have optional variables or
 - you need to initialize them during `init` calls, check with class example.
 */
let optionalUsingSyntacticSugar1: Int? = 5

let optionalUsingDesugaring1: Optional<Int> = 4
let optionalUsingDesugaring2: Optional<Int> = Optional.some(3)

dump(optionalUsingSyntacticSugar1)
dump(optionalUsingDesugaring1)
dump(optionalUsingDesugaring2)

// dump() is similar to print(), but with nicer output
