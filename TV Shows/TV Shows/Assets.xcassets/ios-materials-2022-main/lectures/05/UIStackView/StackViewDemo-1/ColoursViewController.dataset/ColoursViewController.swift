import UIKit

class ColoursViewController: UIViewController {

    @IBOutlet var topView: UIView!
    @IBOutlet var stackView: UIStackView!

}

extension ColoursViewController {
    
    @IBAction func tapOnColour(button: UIButton) {
    
        let currentColour = topView.backgroundColor
        let nextColour = button.backgroundColor
        
        let newButton = UIButton()
        newButton.backgroundColor = currentColour
        newButton.addTarget(self, action: #selector(tapOnColour(button:)), for: .touchUpInside)
        newButton.isHidden = true
        stackView.addArrangedSubview(newButton)
        
        UIView.animate(
            withDuration: 0.5,
            animations: {
                self.topView.backgroundColor = nextColour
                button.isHidden = true
                newButton.isHidden = false
            },
            completion: { (success) in
                self.stackView.removeArrangedSubview(button)
                button.removeFromSuperview()
            })
    }
    
}
