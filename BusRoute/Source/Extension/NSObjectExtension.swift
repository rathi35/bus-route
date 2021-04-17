//
//  NSObjectExtension.swift
//  BusRoute
//
//  Created by Rathi on 4/2/21.
//

import UIKit

extension NSObject {
    
    /// Returns class name string
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}
