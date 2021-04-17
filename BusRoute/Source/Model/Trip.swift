//
//  Trip.swift
//  BusRoute
//
//  Created by Rathi on 4/3/21.
//
import RealmSwift
import Foundation

@objcMembers
class Trip: Object, Decodable {
    dynamic var id: String = ""
    dynamic var totalSeats: Int = 0
    dynamic var avaiable: Int = 0
    dynamic var tripStartTime: String = ""
    dynamic var tripID: String = ""
    dynamic var route: RouteInfo?
    
    private lazy var tripStartDate: Date? = {
        if let duration = route?.getTripDuration() {
            let today = Date().getTodayForTime(tripStartTime)
            return today
        }
        return nil
    }()
    private lazy var tripEndDate: Date? = {
        if let duration = route?.getTripDuration() {
            return tripStartDate?.dateByAddingMin(duration)
        }
        return nil
    }()
    override class func primaryKey() -> String? {
        return "id"
    }
    override class func ignoredProperties() -> [String] {
        return ["tripStartDate","tripEndDate"]
    }
    override init() {
        super.init()
    }
    func getFormattedStartDate() -> String? {
        tripStartDate?.dateString(with: "MMM dd, HH:mm")
    }
    func getFormattedEndDate() -> String? {
        tripEndDate?.dateString(with: "MMM dd, HH:mm")
    }
    func getDepartsInMinutes(_ date: Date = Date()) -> Int {
        return tripStartDate?.minutes(from: date) ?? 0
    }
    
    enum CodingKeys: CodingKey {
        case avaiable
        case totalSeats
        case tripStartTime
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        avaiable = try container.decode(Int.self, forKey: CodingKeys.avaiable)
        totalSeats = try container.decode(Int.self, forKey: CodingKeys.totalSeats)
        tripStartTime = try container.decode(String.self, forKey: CodingKeys.tripStartTime)
        if let parentKey = decoder.userInfo[.parentKey] as? ParentKey {
            self.tripID = parentKey.identifier ?? ""
        } else {
            self.tripID = ""
        }
        id = tripID + tripStartTime
    }
}
