//
//  RouteInfo.swift
//  BusRoute
//
//  Created by Rathi on 4/3/21.
//
import RealmSwift
import Foundation

@objc
class RouteInfo: Object, Codable {
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var source: String = ""
    @objc dynamic private var tripDuration: String = ""
    @objc dynamic var destination: String = ""
    
    //return trip duration in minutes
    func getTripDuration() -> Int {
        switch tripDuration {
        case _ where tripDuration.hasSuffix("min"):
            return Int(tripDuration.replacingOccurrences(of: " min", with: "")) ?? 0
        case _ where tripDuration.hasSuffix("hrs"):
            return (Int(tripDuration.replacingOccurrences(of: "hrs", with: "")) ?? 0) * 60
        default: return 0
        }
        
    }
    override class func primaryKey() -> String? {
        return "id"
    }
}
