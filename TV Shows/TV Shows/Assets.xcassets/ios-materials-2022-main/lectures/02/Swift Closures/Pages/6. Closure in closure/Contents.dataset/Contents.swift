/*:
 [⬅️](@previous) [➡️](@next)

 */
import Cocoa
/*:
 ## ADVANCED

 ```
 { (inputParameters, inputParameters, ...) -> OutputType in
    statement
    statement
    .
    .
    .
    return outputParameters
 }
 ```

 A closure can:
 - take zero or more input parameters, and return zero or more output parameters
 - capture and store references to any constants and variables from the context in which they are defined
 - this is known as closing over those constants and variables.

 Swift handles all of the memory management of capturing for you.

 */
let unnamedClosure = { (inputParameter0: Int, inputParameter1: Int) -> Int in
    return inputParameter0 + inputParameter1
}
// unnamedClosure(<#T##Int#>, <#T##Int#>)
unnamedClosure(5, 5)

func namedClosure(inputParameter0: Int, inputParameter1: Int) -> Int {
    return inputParameter0 + inputParameter1
}
// namedClosure(inputParameter0: <#T##Int#>, inputParameter1: <#T##Int#>)
namedClosure(inputParameter0: 5,inputParameter1: 5)
/*:
 ## Capturing Values 1
 */

// A function that return another function, namely `incrementer` function
func makeIncrementer1(forIncrement amount: Int) -> (() -> Int) {

    var runningTotal = 0

    // `incrementer` function doesn't have any parameters, but it captures local variable `runningTotal`, by reference
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }

    // `incrementer` function is returned, but `runningTotal` will not go out of scope! It will be available as long
    //  as the `incrementer` function is.
    return incrementer
}
let incrementByTen1 = makeIncrementer1(forIncrement: 10)
// incrementByTen1   -> A function, that takes Void and returns Int, `() -> Int`

incrementByTen1()
incrementByTen1()
incrementByTen1()    // -> Take a look on the output value of `runningTotal` on the right ->

// We can also rewrite `makeIncrementer` to use unnamed closure, like so
// A function that returns another function, unnamed function (closure)
func makeIncrementer2(forIncrement amount: Int) -> (() -> Int) {

    var runningTotal = 0

    // unnamed closure doesn't have any parameters, but it captures local variable `runningTotal`, by reference
    return { () -> Int in

        runningTotal += amount
        return runningTotal

    }

}
let incrementByTen2 = makeIncrementer2(forIncrement: 10)
// incrementByTen1   -> A function, that takes Void and returns Int, `() -> Int`

incrementByTen2()
incrementByTen2()
incrementByTen2()    // -> Take a look on the output value of `runningTotal` on the right ->
