//
//  UIDeviceExtension.swift
//  BusRoute
//
//  Created by Rathi on 4/2/21.
//

import UIKit

extension UIDevice {
    
    static var screenHeight: CGFloat {
        if let rootwindow = UIApplication.shared.delegate?.window, let view = rootwindow!.rootViewController?.view {
            return view.bounds.size.height
        }
        return 0
    }
    
    static var screenWidth: CGFloat {
        if let rootwindow = UIApplication.shared.delegate?.window, let view = rootwindow!.rootViewController?.view {
            return view.bounds.size.width
        }
        return 0
    }
    
    static func isiPad() -> Bool {
        UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad
    }
    
    static func isiPhone() -> Bool {
        UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone
    }
    
    static func isStatusBarPortrait() -> Bool {
        UIApplication.shared.statusBarOrientation == .portrait || UIApplication.shared.statusBarOrientation == .portraitUpsideDown
    }
}

