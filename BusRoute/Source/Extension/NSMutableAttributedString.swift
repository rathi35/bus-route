//
//  NSMutableAttributedString.swift
//  BusRoute
//
//  Created by Rathi on 4/3/21.
//

import UIKit

extension NSMutableAttributedString {
    func bold(_ text: String, size: Int, color: UIColor, isLink: Bool? = false, linkValue: String? = nil, isunderLined: Bool? = false) -> NSMutableAttributedString {
        let attrs: [NSAttributedString.Key: Any] = [.font:UIFont.systemFont(ofSize: CGFloat(size), weight: .bold), .foregroundColor: color]
        let boldString = NSMutableAttributedString(string: text, attributes: attrs)
        let startIndex = self.length
        append(boldString)

        if isLink == true, let value = linkValue {
            let length = boldString.length
            self.addAttribute(.link, value: value, range: NSRange.init(location: startIndex, length: length))
        }

        if isunderLined == true {
            let length = boldString.length
            self.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSRange.init(location: startIndex, length: length))
        }

        return self
    }

    func normal(_ text: String, size: Int, color: UIColor, isLink: Bool? = false, linkValue: String? = nil) -> NSMutableAttributedString {
        let attrs: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: CGFloat(size), weight: .regular), .foregroundColor: color]
        let normalString = NSAttributedString(string: text, attributes: attrs)
        let startIndex = self.length

        append(normalString)

        if isLink == true, let value = linkValue {
            let length = normalString.length
            self.addAttribute(.link, value: value, range: NSRange.init(location: startIndex, length: length))
        }

        return self
    }
}
