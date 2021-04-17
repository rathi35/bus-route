//
//  BusRouteResponse.swift
//  BusRoute
//
//  Created by Rathi on 4/3/21.
//

import Foundation

struct BusRouteResponse: Decodable {
    let routeInfo: [RouteInfo]
    let routeTimings: DecodedArray<[Trip]>
}
