//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Victor Tatai on 5/14/21.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String>
    @Published var theme: Theme
    var score: Int {
        get {
            model.score
        }
    }
    private var themes = [
        Theme(name: "Halloween", color: Color.orange, cards: ["👻", "🎃", "🕷"], numberOfCards: {3}),
        Theme(name: "Food", color: Color.red, cards: ["🍔", "🌭", "🌮", "🍟", "🍗"], numberOfCards: {5}),
        Theme(name: "Summer", color: Color.yellow, cards: ["😎", "☀️", "🌞", "⛱"], numberOfCards: {4}),
        Theme(name: "Plants", color: Color.green, cards: ["🌹", "🌸", "🌲"], numberOfCards: {3}),
        Theme(name: "Animals", color: Color.gray, cards: ["🐶", "🐈", "🐮", "🦅", "🦆", "🦝"], numberOfCards: {6}),
        Theme(name: "Winter", color: Color.blue, cards: ["❄️", "☃️", "⛷", "🏔"], numberOfCards: {Int.random(in: 2...4)})
    ]
    
    init() {
        let initialTheme = themes.randomElement()!
        model = EmojiMemoryGame.createMemoryGame(theme: initialTheme)
        theme = initialTheme
    }
    
    static func createMemoryGame(theme: Theme) -> MemoryGame<String> {
        let emojis: Array<String> = theme.cards
        return MemoryGame(numberOfPairsOfCards: theme.numberOfCards) { i in emojis[i] }
    }
    
    // MARK: - Access to the Model
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    // MARK: - Intent(s)
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    func newGame() {
        let initialTheme = themes.randomElement()!
        model = EmojiMemoryGame.createMemoryGame(theme: initialTheme)
        theme = initialTheme
    }
        
    // MARK: - Structs
    struct Theme {
        var name: String
        var color: Color
        var cards: [String]
        var numberOfCards: () -> Int
    }
}
