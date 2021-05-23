//
//  ContentView.swift
//  Memorize
//
//  Created by Victor Tatai on 5/14/21.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            Text(viewModel.theme.name)
            Grid(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    viewModel.choose(card: card)
                }
            }
            .padding()
            .foregroundColor(viewModel.theme.color)
            HStack {
                Button("New Game") {
                    viewModel.newGame()
                }.padding()
                Text("Score: \(viewModel.score)")
            }
        }
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        if card.isFaceUp || !card.isMatched {
            GeometryReader { geometry in
                ZStack {
                    Pie(startAngle: Angle.degrees(-90), endAngle: Angle.degrees(0))
                        .padding(5)
                        .opacity(0.4)
                    Text(card.content)
                        .font(fontSize(geometry))
                }
                .cardify(isFaceUp: card.isFaceUp)
                .padding(5)
            }
        }
    }
    
    private func fontSize(_ geometry: GeometryProxy) -> Font {
        return Font.system(size: min(geometry.size.width, geometry.size.height) * fontScaleFactor)
    }

    // MARK: --Drawing Constants
    private let fontScaleFactor: CGFloat = 0.4
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = EmojiMemoryGame()
        viewModel.choose(card: viewModel.cards[0])
        return EmojiMemoryGameView(viewModel: viewModel)
    }
}
