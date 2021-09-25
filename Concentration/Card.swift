//
//  Card.swift
//  Concentration
//
//  Created by Sina on 2021-03-23.
//

import Foundation

struct Card: Hashable {
    
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int
    
    static func == (lhs: Card, rhs: Card) -> Bool {
            return lhs.identifier == rhs.identifier
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }

    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
