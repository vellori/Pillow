//
//  Identifiable.swift
//  Pillow
//
//  Created by André Vellori on 20/01/2018.
//  Copyright © 2018 André Vellori. All rights reserved.
//

import Foundation

protocol Identifier {
    func key() -> String
    func type() -> String
}

protocol Identifiable {
    var identifier: Identifier { get }
}
