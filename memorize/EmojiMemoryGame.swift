//
//  EmojiMemoryGame.swift
//  memorize
//
//  Created by 11344153 on 2026/3/30.
//

import Foundation

func createCardContent(index: Int) -> String{
    return "A"
}

class EmojiMemoryGame{
    private var model:MemoryGame<String> = MemoryGame<String>(numberOfPairsOfCards: 4,createCardContent: createCardContent)
    
    
    var cards: [MemoryGame<String>.Card]{
        model.cards
    }
}
