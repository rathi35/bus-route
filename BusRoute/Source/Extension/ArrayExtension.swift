//
//  ArrayExtension.swift
//  BusRoute
//
//  Created by Rathi on 4/3/21.
//

import Foundation

extension Array {
    func at(index: Int) -> Element? {
        if index < 0 || index > self.count - 1 {
            return nil
        }
        return self[index]
    }
}
