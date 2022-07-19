import UIKit

class WordStackView: UIStackView {
    
    @IBInspectable var numOfElemets: Int = 5
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup() {
        
        axis = .horizontal
        distribution = .fillEqually
        spacing = 5
        (0..<numOfElemets).forEach { _ in addArrangedSubview(MatrixView()) }
    }
    
}

class MatrixView: UIStackView {
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup() {
        axis = .vertical
        distribution = .fillEqually
        alignment = .fill
        
        for _ in (0..<5) {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.distribution = .fillEqually
            stack.alignment = .fill
            (0..<5).forEach { _ in stack.addArrangedSubview(BoxyView()) }
            
            addArrangedSubview(stack)
        }
    }

    subscript(row: Int, column: Int) -> UIView {
        get {
            let stack = self.arrangedSubviews[row] as! UIStackView
            return stack.arrangedSubviews[column]
        }
    }
}

class BoxyView: UIView {
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup() {
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTap)))
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.black.cgColor
    }
    
    var tap = false
    @objc func didTap() {
        tap = !tap
        backgroundColor = tap ? UIColor.blue : UIColor.white
    }
    
}
