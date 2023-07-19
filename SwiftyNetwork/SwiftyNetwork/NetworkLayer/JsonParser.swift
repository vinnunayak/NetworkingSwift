//
//  JsonParser.swift
//  SwiftyNetwork
//
//  Created by Vinod Nayak Banavath on 19/07/23.
//

import Foundation

protocol JsonParserProtocol {
    func parse<T:Codable>(data: Data?) -> T? where T: Encodable, T: Decodable
}

class JsorParser: JsonParserProtocol {
    
    private let jsonDecoder = JSONDecoder()
    
    /// Parse Data to Generic JSON/POJO Class
    /// - Parameter data: response data
    /// - Returns: JSON/POJO Object
    func parse<T>(data: Data?) -> T? where T : Decodable, T : Encodable {
        if let response = data {
            do{
                //let stringData = (String(data: response, encoding: .utf8)) ?? ""
                if response.isEmpty {
                    let emptyData = "{}".data(using: .utf8)!
                    let decoded = try self.jsonDecoder.decode(T.self, from: emptyData)
                    return decoded
                }else{
                    //print("Parsing Data",stringData)
                    let decoded = try self.jsonDecoder.decode(T.self, from: response)
                    return decoded
                }
            }catch{
                return nil
            }
        }else{
            return nil
        }
    }

}
