/*:
 [⬅️](@previous) [➡️](@next)

 */
import Cocoa
/*:
 ## Zip

 - `zip` will create a sequence, but we usually want array of zipped values, e.g. array of tuples
 - `tuple` is heterogeneous container, it will allow you to put different types in it, like

 - Example:
 (String, Int, Float)
 \
 (String, String)
 \
 (Int, Double)
 \
 ...

 */

let letters = ["a", "b", "c"]
let numbers = [1, 2, 3, 4, 5]

let tuples0 = Array(zip(letters, numbers))
print(tuples0)

let tuples1 = Array(zip(numbers, letters))
print(tuples1)

let tuple:(String, Int) = ("A", 1)
print(tuple.0) // First value
print(tuple.1) // Second value

let namedTuple:(username: String, password: Int) = ("A", 1)
print(namedTuple.username) // First value
print(namedTuple.password) // Second value
