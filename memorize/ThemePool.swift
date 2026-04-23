import Foundation

// 新增 ThemePool Model
struct ThemePool<Item> {
    // 包含 Theme 陣列，並控制存取層級
    private(set) var themes: [Theme] = []
    
    // 新增加入 Theme 的方法
    mutating func addTheme(_ theme: Theme) {
        themes.append(theme)
    }
    
    // 在 ThemePool 底下的 Nested Model
    struct Theme {
        var name: String
        var color: String
        var numberOfPairs: Int
        var items: [Item] // Generic 型別對應 Emoji
    }
}
