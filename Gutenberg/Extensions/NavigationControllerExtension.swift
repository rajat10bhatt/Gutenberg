import UIKit

extension UINavigationController {
    func navigateToCategoryBooks(category: BookCategories) {
        let categoryBooksViewController = Storyboard.main.instantiateViewController(identifier: String(describing: CategoryBooksViewController.self)) { (coder) in
            return CategoryBooksViewController(coder: coder, category: category)
        }
        self.pushViewController(categoryBooksViewController, animated: true)
    }
}
