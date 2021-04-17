//
//  UICollectionViewExtension.swift
//  BusRoute
//
//  Created by Rathi on 4/2/21.
//

import UIKit
extension UITableView {
    
    func dequeueReusableCell<T: UITableViewCell>(_ className: T.Type, indexPath: IndexPath) -> T {
        let className = String.getClassString(className)
        return dequeueReusableCell(withIdentifier: className, for: indexPath) as! T
    }
    
    func registerNib(_ className: AnyClass) {
        let classNameString = String.getClassString(className)
        register(UINib(nibName: classNameString, bundle: .main), forCellReuseIdentifier: classNameString)
    }
    
    func addNoContentBackgroundView(message: String) {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        label.textColor = UIColor.gray
        label.center = self.center
        label.textAlignment = NSTextAlignment.center
        label.text = message
        self.backgroundView = label
    }
    
    func removeBackgroundView() {
        self.backgroundView = nil
    }
}
