/*:
 [⬅️](@previous) [➡️](@next)

 */
import Cocoa
//: ## Zip vs. Enumerated
let letters = ["a", "b", "c"]

print("\n------------------------------------------------------------------\n")
letters.enumerated().forEach { (offset: Int, element: String) in
    print((offset, element))
}

print("\n------------------------------------------------------------------\n")
let interval = 0...letters.count
zip(interval, letters).forEach { (offset: Int, element: String) in
    print((offset, element))
}
