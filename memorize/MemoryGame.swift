//
//  MemoryGame.swift
//  memorize
//
//  Created by 11344153 on 2026/3/30.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    var cards: [Card]
    private(set) var score: Int = 0 // 新增分數屬性，外部唯讀
    
    init(numberOfPairsOfCards: Int,
         createCardContent: (Int) -> CardContent) {
        cards = []
        for index in 0..<numberOfPairsOfCards {
            let cardContent: CardContent = createCardContent(index)
            cards.append(Card(content: cardContent, id: "\(index)a"))
            cards.append(Card(content: cardContent, id: "\(index)b"))
        }
        shuffle()
    }
    
    var lastFaceUpIndex: Int? {
        get {cards.indices.filter({cards[$0].isFaceUp}).oneAndOnly }
        set {cards.indices.forEach({cards[$0].isFaceUp = $0 == newValue})}
    }
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.indices.first(where: { cards[$0].id == card.id}) {
            if cards[chosenIndex].isFaceUp || cards[chosenIndex].isMatched {
                return
            }
            if let lastIndex = lastFaceUpIndex {
                // 判斷是否 Match
                if cards[lastIndex].content == cards[chosenIndex].content {
                    cards[lastIndex].isMatched = true
                    cards[chosenIndex].isMatched = true
                    score += 2 // match 時 +2
                }else {
                    // 翻開第二張卻沒有 match 時判斷是否已翻開過
                    if cards[chosenIndex].hasBeenSeen { score -= 1 }
                    if cards[lastIndex].hasBeenSeen { score -= 1 }
                }
                
                // 兩張牌都已經參與過比對，標記為已翻過 (seen)
                cards[chosenIndex].hasBeenSeen = true
                cards[lastIndex].hasBeenSeen = true
                cards[chosenIndex].isFaceUp = true
            } else{
                lastFaceUpIndex = chosenIndex
            }
            cards[chosenIndex].hasBeenSeen = true
        }
        print("cards: \(cards)")
        print("current score: \(score)")
    }
    
    mutating func shuffle() {
        cards.shuffle()
        print("shuffle cards: \(cards)")
    }
    
    struct Card: Equatable, Identifiable {
        static func == (lhs: MemoryGame<CardContent>.Card, rhs: MemoryGame<CardContent>.Card) -> Bool {
            lhs.content == rhs.content && lhs.isFaceUp == rhs.isFaceUp && lhs.isMatched == rhs.isMatched && lhs.id == rhs.id
        }
        
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var hasBeenSeen: Bool = false // 記住自己有沒有被翻開過
        var content: CardContent
        var id: String
    }
}

extension Array {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
