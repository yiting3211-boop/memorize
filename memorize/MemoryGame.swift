//
//  MemoryGame.swift
//  memorize
//
//  Created by 11344153 on 2026/3/30.
//

import Foundation

struct MemoryGame<CardContent> {
    
    var cards: [Card]
    
    init(numberOfPairsOfCards: Int ,
         createCardContent: (Int) -> CardContent){
        cards = []
        //TODO: init cards
        for index in 0..<numberOfPairsOfCards {
            cards = []
            for index in 0..<numberOfPairsOfCards {
                var cardContent: CardContent = createCardContent(index)
                cards.append(Card(content:cardContent))
                cards.append(Card(content:cardContent))
            }
        }
    }
    func choose(card: Card){
        
    }
    
    struct Card{
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
    }
}
