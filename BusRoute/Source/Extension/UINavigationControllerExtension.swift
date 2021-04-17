//
//  UINavigationControllerExtension.swift
//  BusRoute
//
//  Created by Rathi on 4/2/21.
//

import UIKit

extension UINavigationController {
    func updateAppearnaceToWhiteColor() {
        navigationBar.tintColor = .white
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    func setClearNavBar() {
        navigationBar.shadowImage = UIImage()
        navigationBar.barTintColor = .clear
        navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
    func updateNavBarState(_ top: CGFloat) {
        if top == 0 {
            navigationBar.setBackgroundImage(UIImage(), for: .default)
        } else {
            navigationBar.setBackgroundImage(UIImage.image(from: UIColor(red: 139.0/255.0, green: 188.0/255.0, blue: 154.0/255.0, alpha: min(1, 1 * top / 100))), for: .default)
        }
    }
}
