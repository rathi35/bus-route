//
//  APIRequest.swift
//  BusRoute
//
//  Created by Rathi on 4/3/21.
//

import Foundation
import Alamofire
//import URITemplate

enum APIRequest: APIRequestProtocol {

    // MARK: Home Screen Requests.
    case busRoute

    var baseURL: String? {
        switch self {
        default: return APIRequestContants.baseURL + APIRequestContants.dataPathURL
        }
    }

    var path: String? {
        return nil
    }
}
