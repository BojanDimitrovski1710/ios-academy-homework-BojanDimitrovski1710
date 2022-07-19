import UIKit

class AlignmentViewController: UIViewController {

    @IBOutlet weak var horizontalStackView: UIStackView!
    @IBOutlet weak var verticalStackView: UIStackView!
}

extension AlignmentViewController {
    
    @IBAction func fill() {
        animate(stackView: verticalStackView, to: .fill)
        animate(stackView: horizontalStackView, to: .fill)
    }
    
    @IBAction func topLead() {
        animate(stackView: verticalStackView, to: .leading)
        animate(stackView: horizontalStackView, to: .top)
    }
    
    @IBAction func center() {
        animate(stackView: verticalStackView, to: .center)
        animate(stackView: horizontalStackView, to: .center)
    }
    
    @IBAction func bottomTrail() {
        animate(stackView: verticalStackView, to: .trailing)
        animate(stackView: horizontalStackView, to: .bottom)
    }
    
    @IBAction func firtsBase() {
        animate(stackView: horizontalStackView, to: .firstBaseline)
    }
    
    
    @IBAction func lastBase() {
        animate(stackView: horizontalStackView, to: .lastBaseline)
    }
    
    func animate(stackView: UIStackView, to alignment: UIStackView.Alignment) {
        UIView.animate(withDuration: 0.5) {
            stackView.alignment = alignment
        }
    }
}
