import UIKit

extension UIFont {
    // MARK: Font names
    struct Montserrat {
        static let regular = "Montserrat-Regular"
        static let semiBold = "Montserrat-SemiBold"
    }
    // MARK: Font sizes
    struct Size {
        static let title: CGFloat = 30.0
        static let body: CGFloat = 16.0
    }
    
    static func initFont(name: String, size: CGFloat) -> UIFont {
        return UIFont(name: name, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
