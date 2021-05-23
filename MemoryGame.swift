//
//  MemoryGame.swift
//  Memorize
//
//  Created by Victor Tatai on 5/14/21.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    var score = 0
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            cards.indices
                .filter { index in cards[index].isFaceUp}
                .only
        }
        set {
            cards.indices.forEach { i in
                cards[i].isFaceUp = false
            }
            if let index = newValue {
                cards[index].isFaceUp = true
                cards[index].seen = true
            }
        }
    }
    
    init(numberOfPairsOfCards: () -> Int, cardContentFactory: (Int) -> CardContent) {
        cards = [Card]()
        for pairIndex in 0..<numberOfPairsOfCards() {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        cards = cards.shuffled()
    }
    
    mutating func choose(card: Card) {
        print("card chosen: \(card)")
        let chosenIndex = cards.firstIndex(of: card)!
        // Check if it is an accidental click
        if cards[chosenIndex].isFaceUp || cards[chosenIndex].isMatched {
            return
        }
        if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard { // One card was already selected
            if cards[potentialMatchIndex].content == cards[chosenIndex].content {
                // We have a match!
                cards[potentialMatchIndex].isMatched = true
                cards[chosenIndex].isMatched = true
                score += 2
                print("Score \(score)")
            } else {
                if cards[chosenIndex].seen { score -= 1 }
                cards[chosenIndex].seen = true
                if cards[potentialMatchIndex].seen { score -= 1 }
                cards[potentialMatchIndex].seen = true
                print("Score \(score)")
            }
            cards[chosenIndex].isFaceUp = true
        } else {
            // No card selected
            indexOfTheOneAndOnlyFaceUpCard = chosenIndex
        }
    }
    
    struct Card: Identifiable, Equatable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
        var seen = false
        
        static func == (lhs: MemoryGame<CardContent>.Card, rhs: MemoryGame<CardContent>.Card) -> Bool {
            lhs.id == rhs.id && lhs.isFaceUp == rhs.isFaceUp && lhs.isMatched == rhs.isMatched && lhs.content == rhs.content
        }
    }
}
