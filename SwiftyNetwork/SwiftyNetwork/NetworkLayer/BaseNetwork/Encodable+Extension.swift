//
//  Encodable+Extension.swift
//  SwiftyNetwork
//
//  Created by Vinod Nayak Banavath on 19/07/23.
//

import Foundation

extension Encodable {
    func encode() -> Data? {
        do {
            return try JSONEncoder().encode(self)
        }catch{
            return nil
        }
    }
}
