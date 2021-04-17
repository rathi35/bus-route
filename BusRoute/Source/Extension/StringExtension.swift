//
//  StringExtension.swift
//  BusRoute
//
//  Created by Rathi on 4/2/21.
//
import UIKit

extension String {
    static func getClassString(_ class: AnyClass) -> String {
        String(describing: `class`.self)
    }
}
