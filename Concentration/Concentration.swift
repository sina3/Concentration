//
//  Concentration.swift
//  Concentration
//
//  Created by Sina on 2021-03-23.
//

import Foundation

struct Concentration {
    var cardsTemp = [Card]()
    var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    // Called every time a card is touched
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCards(at: \(index)): chosen index not in the cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    // Creates set of cards for the initializer
    mutating func cardsTemp(numberOfPairs: Int) -> [Card] {
        for _ in 1...numberOfPairs {
            let card = Card()
            cardsTemp += [card, card]
        }
        return cardsTemp
    }
    
    mutating func reshuffle(unshuffledCards: [Card]) -> [Card] {
        var unshuffled = unshuffledCards
        
        for index in 0..<unshuffledCards.count {
            if unshuffled.count > 0 {
                let randomIndex = Int(arc4random_uniform(UInt32(unshuffled.count)))
                cards[index] = unshuffled.remove(at: randomIndex)
            }
        }
        return cards
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have at least one pair of cards")
        cardsTemp = cardsTemp(numberOfPairs: numberOfPairsOfCards)
        cards = cardsTemp
        cards = reshuffle(unshuffledCards: cardsTemp)


    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
