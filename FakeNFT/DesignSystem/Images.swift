import UIKit

extension UIImage {
    enum TabBar {
        static let profile = UIImage(named: "Profile")
        static let catalog = UIImage(named: "Catalog")
        static let cart = UIImage(named: "Cart")
        static let statistics = UIImage(named: "Statistics")
    }

    enum NFTCard {
        static let heart = UIImage(named: "Heart")
        static let star = UIImage(named: "Star")
    }

    enum NavigationBar {
        static let backward = UIImage(named: "Backward")
        static let forward = UIImage(named: "Forward")
        static let close = UIImage(named: "Close")
        static let edit = UIImage(named: "Edit")
        static let sort = UIImage(named: "Sort")
    }

    enum ProfileTable {
        static let chevron = UIImage(systemName: "chevron.right")?.withRenderingMode(.alwaysTemplate)
    }
    
    enum User {
        static let avatarPlaceholder = UIImage(named: "avatar-placeholder")
    }
}
