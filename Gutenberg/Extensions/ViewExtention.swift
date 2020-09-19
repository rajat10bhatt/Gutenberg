import UIKit

extension UIView: ReusableView {
    // Storyboard configurable corner radius
    // swiftlint:disable valid_ibinspectable
    @IBInspectable var layerCornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    func addShadow(radius: CGFloat, color: UIColor = #colorLiteral(red: 0.8274509804, green: 0.8196078431, blue: 0.9333333333, alpha: 1)) {
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = radius
        self.layer.shadowColor =  color.cgColor
        self.layer.shadowOpacity = 0.5
    }
}
