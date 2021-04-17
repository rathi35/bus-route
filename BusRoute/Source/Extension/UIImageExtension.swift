//
//  UIImageExtension.swift
//  BusRoute
//
//  Created by Rathi on 4/3/21.
//

import UIKit
extension UIImage {
    
    static func image(from color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}
