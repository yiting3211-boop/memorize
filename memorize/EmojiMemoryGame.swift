//
//  EmojiMemoryGame.swift
//  memorize
//
//  Created by 11344153 on 2026/3/30.
//
//private static var emojis = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","牛","狗"]

//
//  EmojiMemoryGame.swift
//  memorize
//

import SwiftUI

@Observable
class EmojiMemoryGame {
    typealias Theme = ThemePool<String>.Theme
    
    // 在 ViewModel 中建立 ThemePool 並呼叫加入 Theme 的方法
    private static func createThemePool() -> ThemePool<String> {
        var pool = ThemePool<String>()
        pool.addTheme(Theme(name: "動物", color: "orange", numberOfPairs: 6, items: ["🐶","🐱","🐭","🐹","🐰","🦊","🐻","🐼","🐨","🐯","🦁","🐮"]))
        pool.addTheme(Theme(name: "運動", color: "blue", numberOfPairs: 6, items: ["⚽️","🏀","🏈","⚾️","🥎","🎾","🏐","🏉","🥏","🎱","🪀","🏓"]))
        pool.addTheme(Theme(name: "水果", color: "green", numberOfPairs: 8, items: ["🍎","🍐","🍊","🍋","🍌","🍉","🍇","🍓","🍈","🍒","🍑","🥭"]))
        pool.addTheme(Theme(name: "車輛", color: "red", numberOfPairs: 7, items: ["🚗","🚕","🚙","🚌","🚎","🏎","🚓","🚑","🚒","🚐","🛻","🚚"]))
        return pool
    }
    
    private var themePool: ThemePool<String>
    private(set) var currentTheme: Theme
    private var model: MemoryGame<String>
    
    // 自訂定義 init，決定建構物件的順序
    // 自訂定義 init，決定建構物件的順序
        init() {
            // 1. 先使用「區域變數」來建立與暫存資料
            let initialThemePool = EmojiMemoryGame.createThemePool()
            let randomTheme = initialThemePool.themes.randomElement()!
            
            // 2. 將準備好的資料一口氣賦值給所有屬性
            self.themePool = initialThemePool
            self.currentTheme = randomTheme
            self.model = EmojiMemoryGame.createMemoryGame(with: randomTheme)
        }
    
    // createMemoryGame 的來源改從 Theme 來
    private static func createMemoryGame(with theme: Theme) -> MemoryGame<String> {
        // 被選定的 Theme 需隨機提供 items 內容
        let shuffledItems = theme.items.shuffled()
        let pairsToPlay = min(theme.numberOfPairs, shuffledItems.count)
        
        return MemoryGame<String>(numberOfPairsOfCards: max(2, pairsToPlay)) { index in
            shuffledItems[index]
        }
    }
    
    var cards: [MemoryGame<String>.Card] {
        model.cards
    }
    
    var score: Int {
        model.score
    }
    
    // 將 String 轉為 SwiftUI Color 供 View 使用
    var themeColor: Color {
        switch currentTheme.color {
        case "orange": return .orange
        case "blue": return .blue
        case "green": return .green
        case "red": return .red
        default: return .black
        }
    }
    
    // MARK: - Intents
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    // 供 View 重新開始一個全新遊戲
    func newGame() {
        currentTheme = themePool.themes.randomElement()! // 隨機選擇主題
        model = EmojiMemoryGame.createMemoryGame(with: currentTheme)
    }
}
