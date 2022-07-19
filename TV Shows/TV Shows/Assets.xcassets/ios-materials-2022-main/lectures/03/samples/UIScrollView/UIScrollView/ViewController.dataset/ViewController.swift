import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        DispatchQueue.main.async {
            print("123")
        }

        DispatchQueue.main.async {
            print("124")
        }

        let dis = DispatchQueue.init(label: "", qos: .background, attributes: .concurrent)
        dis.async {
            print("dfs")
        }
        dis.async {
            print("dfs 2")
        }
        DispatchQueue.global().async { // API call na background thredu
            print("125")
            DispatchQueue.main.async { //
                print("124")
            }
        }
    }
}
