//
//  BaseNetwork.swift
//  SwiftyNetwork
//
//  Created by Vinod Nayak Banavath on 19/07/23.
//

import Foundation

typealias Request = (URLRequest) -> Void
typealias Headers = [String: String]
typealias QueryParams = [String: Any]

class BaseNetwork {
    
    /// Build URL using the following params to make a service call
    /// - Parameters:
    ///   - url: endpoint or complete URL
    ///   - queryparams: URLQueryItems that will include in the url
    ///   - headers: Http Headers
    ///   - httpMethod: Http Method
    ///   - request: returns the URLRequest
    func buildURL(
        url: String?,
        queryparams: QueryParams?,
        headers: Headers = [:],
        httpMethod: HttpMethod,
        request: Request
    ){
        guard let url = url else { return }
        var components = URLComponents(string: url)
        var queryItems = [URLQueryItem]()
        if let params = queryparams {
            params.forEach { (key: String, value: Any) in
                queryItems.append(URLQueryItem(name: key, value: "\(value)"))
            }
            components?.queryItems = queryItems
        }
        
        guard let bakedURL = components?.url else { return }
        var urlRequest = URLRequest(url: bakedURL)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = headers
        request(urlRequest)
    }
    
    /// Build URL using the following params to make a service call
    /// - Parameters:
    ///   - url: endpoint or complete URL
    ///   - queryparams: URLQueryItems that will include in the url
    ///   - headers: Http Headers
    ///   - httpMethod: Http Method
    ///   - httpBody: includes Httpbody from Encodable object
    ///   - request: returns the URLRequest
    func buildURL(
        url: String?,
        queryparams: QueryParams?,
        headers: Headers = [:],
        httpMethod: HttpMethod,
        body: Encodable?,
        request: Request
    ){
        guard let url = url else { return }
        var components = URLComponents(string: url)
        var queryItems = [URLQueryItem]()
        if let params = queryparams {
            params.forEach { (key: String, value: Any) in
                queryItems.append(URLQueryItem(name: key, value: "\(value)"))
            }
            components?.queryItems = queryItems
        }
        
        guard let bakedURL = components?.url else { return }
        var urlRequest = URLRequest(url: bakedURL)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.httpBody = body?.encode()
        request(urlRequest)
    }
    
}
