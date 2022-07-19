import Cocoa

/*:
 ## C - like enum

- but as you can see, this is not an __Integer__
 */

enum Direction {
    case north
    case east
    case south
    case west
}

let north = Direction.north
let west = Direction.west

print(north)
print(west)


/*:
 ## Swift enum

- Swift enums are however much more powerful
- they can't have __inheritance__
- but you can __extend__ them, or add __protocol__ conformance.
 */

extension Direction {

    var description: String {
        switch self {
        case .north:
            return "North"
        case .east:
            return "East"
        case .south:
            return "South"
        case .west:
            return "West"
        }
    }
}

protocol Debug {
    func debugDescription()
}

extension Direction: Debug {

    func debugDescription() {
        dump(self)
    }
}

/*:
 ### Swift enum - associated value

- but the pinnacle of enums are something called associated value
- basically, each case can hold some value, any value that you can think off ...
 */

enum MyEnum {
    case first(Int)
    case second(String)
}

let myEnum = MyEnum.first(4)

switch myEnum {
case .first(let intValue):
    print(intValue)
case .second(let stringValue):
    print(stringValue)
}

/*:
 ### When to use
- __ENUMS__ should be use when you have __OR (||)__
- __STRUCT__ should be use when you have __AND (&&)__
 
 >
    STRUCT - username AND password
 
     struct User {
        let userName: String
        let password: String
     }
 
 >
    ENUM - 200 OR 404 OR ...
 
     enum MyError {
        case 200
        case 404
     }
 
- __ENUMS__ can be also called __SUM TYPES__, and __STRUCT/CLASSES__ __PRODUCT TYPES__
 
- take a look at this
    - https://mislavjavor.github.io/2017-04-19/Swift-enums-are-sum-types.-That-makes-them-very-interesting/
 
 */

/*:
 ### How to use
- In Swift you can actually pattern match over anything, well almost :D
- take a look at this
    - https://appventure.me/2015/08/20/swift-pattern-matching-in-detail/ (Swift 3 so there could be some issues)
 */

enum TraderType {
    case singleGuy
    case company
}

enum Trades {
    case buy(stock: String, amount: Int, stockPrice: Float, type: TraderType)
    case sell(stock: String, amount: Int, stockPrice: Float, type: TraderType)
}

let aTrade = Trades.sell(stock: "GOOG", amount: 100, stockPrice: 650.0, type: TraderType.company)

switch aTrade {
case let .buy(stock, amount, _, TraderType.singleGuy):
    print("STOCK: \(stock), AMOUNT: \(amount)")
case let .sell(stock, amount, _, TraderType.singleGuy):
    print("STOCK: \(stock), AMOUNT: \(amount)")
case let .buy(stock, amount, _, TraderType.company):
    print("STOCK: \(stock), AMOUNT: \(amount)")
case let .sell(stock, amount, _, TraderType.company):
    print("STOCK: \(stock), AMOUNT: \(amount)")
}
