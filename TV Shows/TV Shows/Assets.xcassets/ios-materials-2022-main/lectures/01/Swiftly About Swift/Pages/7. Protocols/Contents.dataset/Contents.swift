/*:
 [⬅️](@previous) [➡️](@next)

 */
import Cocoa
/*:
 Protocols - similar to interface in Java
 
 - defines a blueprint of methods, properties, and other requirements that suit a particular task or piece of functionality.
 - can be adopted by a class, structure, or enumeration to provide an actual implementation of those requirements
 - type that satisfies the requirements of a protocol is said to _conform_ to that protocol.
 - [read more here](https://docs.swift.org/swift-book/LanguageGuide/Protocols.html)
 */
protocol FullyNamed {
    var fullName: String { get }
}

//: ## Conformance

struct FullPerson: FullyNamed {
    let fullName: String
}
let steve = FullPerson(fullName: "Steve Jobs")
print(steve.fullName)

//: ## A bit more complex class

class Starship: FullyNamed {
    var prefix: String?
    var name: String
    
    // Custom init, with default value for prefix
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    
    var fullName: String {
        if let prefix = prefix {
            return "\(prefix) \(name)"
        } else {
            return name
        }
    }
}
var ncc1701 = Starship(name: "Enterprise", prefix: "USS")
print(ncc1701.fullName)

//: ## Methods requirement + extension conformance

protocol WarpSettable {
    func engageWarp(at warpFactor: Int)
}

// Protocol conformance
extension Starship: WarpSettable {

    func engageWarp(at warpFactor: Int) {
        print("Engage warp \(warpFactor)!")
    }
}

ncc1701.engageWarp(at: 6)
