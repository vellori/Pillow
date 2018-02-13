//
//  Observation.swift
//  Pillow
//
//  Created by André Vellori on 20/01/2018.
//  Copyright © 2018 André Vellori. All rights reserved.
//

import Foundation
import CouchbaseLiteSwift

protocol ChangeObserverDelegateProtocol {
    func objectDidChange()
}

class ChangeObserver {
    var tokens = [String:  (ListenerToken, Database)]()
    
    func observe<T: Codable & Identifiable>(identifier: Identifier, with database: Database = Database(), callback: @escaping (T?) -> (), queue: DispatchQueue?) {
        let token = database.dbRef.addDocumentChangeListener(withID: identifier.key(), queue: queue) { (change) in
            let res: T? = DatabaseInOut().load(identifier: identifier)
            callback(res)
        }
        tokens[identifier.key()] = (token, database)
    }
    
    func unregister(identifier: Identifier) {
        guard let token = tokens[identifier.key()] else {
            return
        }
        token.1.dbRef.removeChangeListener(withToken: token.0)
        tokens[identifier.key()] = nil
    }
    
    func unregister() {
        for (_, token) in tokens {
            token.1.dbRef.removeChangeListener(withToken: token.0)
        }
        tokens.removeAll()
    }
    
    deinit {
        unregister()
    }
}
