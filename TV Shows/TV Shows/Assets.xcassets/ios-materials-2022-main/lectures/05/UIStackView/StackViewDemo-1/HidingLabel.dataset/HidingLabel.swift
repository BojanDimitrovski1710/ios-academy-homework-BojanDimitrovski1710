import UIKit

class HidingLabel: UILabel {

    override func awakeFromNib() {
        super.awakeFromNib()
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(HidingLabel.hideAnimated)))
    }
    
    @objc func hideAnimated() {
        UIView.animate(withDuration: 0.5) { 
            self.isHidden = true
        }
    }

}

class BorderLabel: HidingLabel {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
    }
    
}
