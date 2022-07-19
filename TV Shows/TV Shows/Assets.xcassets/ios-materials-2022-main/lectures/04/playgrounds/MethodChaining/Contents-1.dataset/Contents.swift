
import Cocoa

/*:
 ## Chaining

- Making functions chainable is quite easy and can allow us to write using an almost DSL-like syntax.
- We’ll add a new function that does something and then return self. It's that simple.
 */

extension Int {
    func add(_ number: Int) -> Int {
        return self + number
    }
    func sub(_ number: Int) -> Int {
        return self - number
    }
}
5.add(4).add(3).sub(4).add(2)


extension String {
    func toUpperCase() -> String {
        return self.uppercased()
    }
    func toLowerCase() -> String {
        return self.lowercased()
    }
}
"ivan".toUpperCase()

/*:
 ## Chaining using HoFs

- Instead of writing extensions for each specific type, you can take leverage by using higher order functions
> In order for you to use let's say `map` function, `map` should be defined on that type!
 */

let maybeNumber = Optional(5)

maybeNumber
    .map { $0 + 5 }
    .map { $0 - 4 }

let maybeNumbers = [1, 2, 3]

maybeNumbers
    .map { $0 + 1 }
    .filter { $0 > 3 }
    .reduce(0, +)
