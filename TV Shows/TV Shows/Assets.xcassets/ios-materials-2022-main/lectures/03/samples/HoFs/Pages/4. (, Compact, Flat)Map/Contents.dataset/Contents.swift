/*:
 [⬅️](@previous) [➡️](@next)

 */
import Cocoa
/*:
 ## Map vs. Flat Map vs. Compact Map

 - `flatMap` is `map` and then `flatten`
 - `flatMap` can be found under different name in functional languages and is called `bind`
 - `flatMap` is one of the properties of a concept called MONADs
 - `flatMap` is generally used when you encounter nesting problems

 - Example:
 [[1,2], [3,4]]                             ->           [1,2,3,4]
 \
 Optional<Optional<Int>>    ->           Optional<Int>

 - `compactMap` filters `nil` values

 */
let x = [1, 2, 3, nil, 4].map { $0 }
let y = [1, 2, 3, nil, 4].compactMap { $0 }

print(x)
print(y)

print("\n-----------------------------\n")
let start1 = [[1, 2], [3, 4]]
let start2 = [[1, nil], [3, 4]]

let end1 = start1.flatMap { $0 }
let end2 = start2.flatMap { $0 }
let end3 = end2.compactMap { $0 }

print(end1)
print(end2)
print(end3)
