//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Victor Tatai on 5/14/21.
//

import SwiftUI

@main
struct MemorizeApp: App {
    var body: some Scene {
        WindowGroup {
            let game = EmojiMemoryGame()
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
