/*:
 [⬅️](@previous) [➡️](@next)

 */
import Cocoa
//: ## Chaining with HoFs
print("-----------------------------\n")
let numbers = [1, 2, 3, 4, 5]

numbers
    .map { (number: Int) -> String in
        return "\(number)" // Convert Int to String
    }
    .map { (number: String) -> Int in
        return Int(number) ?? 0 // Convert String to Int and fallback to 0 if conversion fails (observe returned type, it is not ab optional)
    }
    .filter { (number: Int) -> Bool in
        return number > 2 // Include numbers only greater than 2
    }
    .forEach { (number: Int) in
        print(number) // Print the result
    }
print("\n-----------------------------\n")
//: Or written shortly:
numbers
    .map { "\($0)" } // Convert Int to String
    .map { Int($0) ?? 0 } // Convert String to Int and fallback to 0 if conversion fails (observer returned type, it is not optiona)
    .filter { $0 > 2 } // Include numbers only greater than 2
    .forEach { print($0) } // Print the result
