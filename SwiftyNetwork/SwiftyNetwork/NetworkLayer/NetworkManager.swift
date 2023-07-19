//
//  NetworkManager.swift
//  SwiftyNetwork
//
//  Created by Vinod Nayak Banavath on 19/07/23.
//

import Foundation

typealias Response = (Data?, String?) -> Void

class NetworkManager: BaseNetwork {
    
    static let shared = NetworkManager()
    private let session = URLSession.shared
    
    /// Call Get URL with Queryparams
    /// - Parameters:
    ///   - url: url or endpoint
    ///   - queryparams: pass queryparams to the url
    ///   - response: Response will returned
    func get(url: String, queryparams: QueryParams?, response: @escaping Response) {
        buildURL(url: url, queryparams: queryparams, httpMethod: .get) { request in
            processRequest(request: request) { data, error in
                response(data, error)
            }
        }
    }
    
    /// Call Get URL without Queryparams
    /// - Parameters:
    ///   - url: url or endpoint
    ///   - response: Response will returned
    func get(url: String, response: @escaping Response) {
        buildURL(url: url, queryparams: nil, httpMethod: .get) { request in
            processRequest(request: request) { data, error in
                response(data, error)
            }
        }
    }
    
    /// Call Post URL with Queryparams and httpbody
    /// - Parameters:
    ///   - url: url or endpoint
    ///   - queryparams: pass queryparams to the url
    ///   - requestBody: pass requestBody to the url
    ///   - response: Response will returned
    func post(url: String, queryparams: QueryParams, requestBody: Encodable, response: @escaping Response) {
        buildURL(url: url, queryparams: queryparams, httpMethod: .post, body: requestBody) { request in
            processRequest(request: request) { data, error in
                response(data, error)
            }
        }
    }
    
    /// Call Post URL with httpbody
    /// - Parameters:
    ///   - url: url or endpoint
    ///   - requestBody: pass requestBody to the url
    ///   - response: Response will returned
    func post(url: String, requestBody: Encodable, response: @escaping Response) {
        buildURL(url: url, queryparams: nil, httpMethod: .post, body: requestBody) { request in
            processRequest(request: request) { data, error in
                response(data, error)
            }
        }
    }
    
    /// Process the prepared URL and call Server
    /// - Parameters:
    ///   - request: Complete URLRequest
    ///   - response: Response will returned
    func processRequest(request: URLRequest, response: @escaping Response) {
        session.dataTask(with: request) { data, urlResponse, error in
            guard let httpResponse = urlResponse as? HTTPURLResponse else { return }
            if 200...209 ~= httpResponse.statusCode {
                response(data, nil)
            }else{
                let errorMessage = error?.localizedDescription
                response(nil, errorMessage)
            }
        }.resume()
    }
}
