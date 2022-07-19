/*:
 [⬅️](@previous) [➡️](@next)

 */
import Cocoa
/*:
 ## OWNERSHIP
 >If you remember when we talked about ARC (Automatic Reference Counting), we said that if two reference types have strong reference to each other, we will cause a retain cycle, well, we can also cause this with closures.
 */
//: RETAIN CYCLE
class MyClass1 {

    // MARK: - Variables -
    let myNumber: Int = 4
    var sum: Int?
    var myClosure: ((Int) -> Void)?

    // MARK: - Init -
    init() {
        self.myFunc()
    }

    // MARK: - Functions -
    func myFunc() {

        self.myClosure = { (number: Int) -> Void in
            self.sum = self.myNumber + number
        }

        self.myClosure?(5)

    }
}

//: NONRETAIN CYCLE
class MyClass2 {

    // MARK: - Variables -
    let myNumber: Int = 4
    var sum: Int?
    var myClosure: ((Int) -> Void)?

    // MARK: - Init -
    init() {
        self.myFunc()
    }

    // MARK: - Functions -
    func myFunc() {

        self.myClosure = { [weak self] (number: Int) -> Void in
            guard let strongSelf = self else { return }
            self?.sum = strongSelf.myNumber + number
        }

        self.myClosure?(5)

    }

}
