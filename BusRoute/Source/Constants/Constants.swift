//
//  UIStringConstants.swift
//  BusRoute
//
//  Created by Rathi on 4/2/21.
//

import UIKit

// To store storyboard name constant
enum StoryBoardNameConstants {
    static let main  = "Main"
}

//https://open-app1.herokuapp.com/data
enum APIRequestContants {
    static let baseURL = "https://open-app1.herokuapp.com"
    static let dataPathURL = "/data"
}

enum ScreenTitle {
    static let route = "Routes"
}

enum UIStrings {
    static let travelTime = "Travel time: %d min"
    static let totalSeat = "Total seat: %d"
    static let availableSeat = "Available seat: %d"
    static let minute = "min"
}

enum FontWeight {
    case regular
    case bold
}

extension UIColor {
    static let themeColor = UIColor(red: 139.0/255.0, green: 188.0/255.0, blue: 154.0/255.0, alpha: 1)
}
