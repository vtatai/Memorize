//
//  Array+Only.swift
//  Memorize
//
//  Created by Victor Tatai on 5/18/21.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
