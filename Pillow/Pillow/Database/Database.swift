//
//  Database.swift
//  Pillow
//
//  Created by André Vellori on 20/01/2018.
//  Copyright © 2018 André Vellori. All rights reserved.
//

import Foundation
import CouchbaseLiteSwift

struct Database {
    static let defaultDBName = "default"
    var dbRef: CouchbaseLiteSwift.Database!
    
    init(dbName: String = defaultDBName) {
        do {
            dbRef = try CouchbaseLiteSwift.Database(name: dbName)
        } catch {
            assertionFailure("Can't open DB, this is a serious error and what the implementation will try to do in a production package is to remove the DB and create it from scratch")
            try? CouchbaseLiteSwift.Database.delete(withName: Database.defaultDBName)
            dbRef = try? CouchbaseLiteSwift.Database(name: Database.defaultDBName)
        }
    }
}

struct DatabaseInOut {
    static let dataKey = "data"
    
    func save<T: Identifiable & Codable>(object: T, in database: Database = Database()) -> Bool {
        let key = object.identifier.key()
        let dbRef = database.dbRef
        let data = CodableConverter().dataStruct(with: object)
        var doc: MutableDocument!
        
        if let aDoc = database.dbRef.document(withID: key)?.toMutable() {
            aDoc.setData([DatabaseInOut.dataKey: data])
            doc = aDoc
        } else {
            doc = MutableDocument(withID: key, data: [DatabaseInOut.dataKey: object])
        }
        do {
            try dbRef?.saveDocument(doc)
            return true
        } catch {
            assertionFailure("Can't save because \(error)")
        }
        return false
    }
    
    func load<T: Codable>(identifier: Identifier, from database: Database = Database()) -> T? {
        let dbRef = database.dbRef
        
        if  let doc = dbRef?.document(withID: identifier.key()),
            let value = doc.value(forKey: DatabaseInOut.dataKey) {
                return CodableConverter().object(with: value)
        }
        return nil
    }
}
