//
//  Codable+Couchbase.swift
//  Pillow
//
//  Created by André Vellori on 20/01/2018.
//  Copyright © 2018 André Vellori. All rights reserved.
//

import Foundation

struct CodableConverter {
    func dataStruct<T: Encodable>(with object: T) -> Any {
        do {
            let json = try JSONEncoder().encode(object)
            return try JSONSerialization.jsonObject(with: json, options: [])
        } catch {
            assertionFailure("Can't encode to json because \(error)")
            return [String: Any]()
        }
    }
    
    func object<T: Codable>(with jsonObject: Any) -> T? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: [])
            return try JSONDecoder().decode(T.self, from: jsonData)
        } catch {
            assertionFailure("Can't decode to object because \(error)")
            return nil
        }
    }
}
