/*:
 [⬅️](@previous) [➡️](@next)

 */
import Cocoa
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true
/*:
 ## Sync vs. Async
 */

//: Imagine that you have function call like this:

func downloadUserData() -> String {
    // Do some long running operation
    // I can't think of a single valid reason why would you want to use `sleep` in a production codebase, so don't ;)
    sleep(2)
    return "iOS Academy 2021"
}

//: and you call it like this;
/// Date() - it fetches current timestamp
print("[BLOCKING] Start Time: \(Date())")

let userData = downloadUserData() //: --------> we stopped here, everything bellow this line will not be executed until we finish (return) from `donwnloadUserData`.
print("[BLOCKING] Print Time: \(Date()), DATA: \(userData)")

print("[BLOCKING] End Time: \(Date())")
/*:
 Now, if this function would take a long time to return, you will block the thread on which you
 started execution which will in turn block all of your code bellow that.

 And on top of that, if you started this on the **Main Thread (UI thread)**, you will block user interface (app will freeze), which is something that you never want to do!

 >Try playing with Playgrounds and increase `sleep` and `deadline`

 Instead, you would most likely want do to something like this;
 */
print("\n")
print("***************************************************************")
print("\n")

print("[NON-BLOCKING] Start Time: \(Date())")

func downloadUserData(closure: @escaping (_ userData: String) -> Void) {
    // Do some long running operation
    // We will learn more about DispatchQueue (GCD) later on ;)
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        closure("iOS Academy 2021")
    }
}


downloadUserData() { (userData: String) -> Void in
    // This can be called right away or sometimes in the future, or never ...
    print("[NON-BLOCKING] Print Time: \(Date()), DATA: \(userData)")
}
print("[NON-BLOCKING] End Time: \(Date())")
//: This is same as:
/*
downloadUserData(closure: { (userData: String) -> Void in
    // This can be called right away or sometimes in the future, or never ...
    print("[NON-BLOCKING] Print Time: \(Date()), DATA: \(userData)")
})
*/
/*:
 > In Swift, if the last parameter to the function is `closure`,
 > we can use something called trailing closure syntax. Basically what it means is
 > you close the braces for function call, and put the closure braces after it.
 > In Swift, functions are also **closures**, just named closures.
 */
