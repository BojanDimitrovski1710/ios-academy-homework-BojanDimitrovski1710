import UIKit

class TransposeViewController: UIViewController {
    
    @IBOutlet weak var matrixStackView: UIStackView!
    @IBOutlet var nestedStackViews: [UIStackView]!
    
    var transposed = false
}

extension TransposeViewController {
    
    @IBAction func transpose() {
        UIView.animate(withDuration: 0.5) {
            self.nestedStackViews.forEach {
                $0.axis = self.transposed ? .horizontal : .vertical
            }
            self.matrixStackView.axis = self.transposed ? .vertical : .horizontal
            self.transposed = !self.transposed
        }
    }
    
}
