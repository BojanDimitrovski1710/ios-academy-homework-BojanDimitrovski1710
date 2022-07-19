import UIKit

class DistributionViewController: UIViewController {

    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension DistributionViewController {
    
    @IBAction func fillDistribution() {
        animate(to: .fill)
    }
    
    
    @IBAction func fillEqualDistribution() {
        animate(to: .fillEqually)
    }
    
    @IBAction func fillPropDistribution() {
        animate(to: .fillProportionally)
    }
    
    @IBAction func equalSpaceDistribution() {
        animate(to: .equalSpacing)
    }
    
    @IBAction func equalCenterDistribution() {
        animate(to: .equalCentering)
    }
    
    func animate(to distribution: UIStackView.Distribution) {
        UIView.animate(withDuration: 0.5) {
            self.stackView.distribution = distribution
        }
    }
}
