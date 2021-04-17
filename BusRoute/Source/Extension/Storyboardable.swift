//
//  Storyboardable.swift
//  BusRoute
//
//  Created by Rathi on 4/2/21.
//

import UIKit

// MARK: - Storyboardable

protocol Storyboardable: class {
    
    static var storyboardName: String { get }
    
    static func instance() -> Self
    
}

// MARK: - Storyboardable Extension

extension Storyboardable where Self: UIViewController {
    
    static var storyboardName: String {
        return String(describing: self)
    }
    
    // MARK: - Functions
    
    static func instance() -> Self {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: className) as? Self else {
            fatalError("Could not instantiate view controller : \(className)")
        }
        return viewController
    }
    
}
