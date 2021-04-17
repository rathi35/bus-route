//
//  APIRequestProtocol.swift
//  BusRoute
//
//  Created by Rathi on 4/3/21.
//

import Foundation
import Alamofire
typealias RequestParams = [String: Any]
// MARK: Initialization
protocol APIRequestProtocol: URLRequestConvertible {
    var baseURL: String? { get }
    var path: String? { get }
    var method: Alamofire.HTTPMethod { get }
    var headers: Alamofire.HTTPHeaders { get }
    var parameters: RequestParams? { get }
    var encoding: Alamofire.ParameterEncoding { get }
}
// MARK: Extension Methods
extension APIRequestProtocol {

    var method: Alamofire.HTTPMethod { return .get }
    var headers: Alamofire.HTTPHeaders { return Alamofire.HTTPHeaders() }
    var parameters: RequestParams? { return nil }
    var encoding: Alamofire.ParameterEncoding { return Alamofire.URLEncoding.queryString }
}
extension APIRequestProtocol {
    func asURLRequest() throws -> URLRequest {
        guard let urlString =  baseURL else {
            throw AFError.parameterEncodingFailed(reason: .missingURL)
        }
        var resourceURL = try urlString.asURL()
        if let pathComponent =  path {
            resourceURL = resourceURL.appendingPathComponent(pathComponent)
        }
        let urlRequest = try URLRequest(url: resourceURL, method: method, headers: headers)
        let request = try encoding.encode(urlRequest, with: parameters)
        return request
    }
}

