//
//  ContentView.swift
//  memorize
//
//  Created by 11344153 on 2026/3/16.
//

import SwiftUI

struct ContentView: View {
    var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            // 頂部顯示區塊：主題名稱與分數
            HStack {
                Text(viewModel.currentTheme.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
                Text("Score: \(viewModel.score)")
                    .font(.title2)
                    .fontWeight(.semibold)
                    // 分數為負時可以加上特別標示，這裡依照題目以明顯顏色呈現
                    .foregroundColor(viewModel.score < 0 ? .red : viewModel.themeColor)
            }
            .padding(.horizontal)
            
            cardList
                .animation(.default, value: viewModel.cards)
            
            Spacer()
            
            // 底部按鈕區
            HStack(spacing: 40) {
                Button("Shuffle") {
                    viewModel.shuffle()
                }
                .font(.title2)
                
                // 新增重新開始遊戲的按鈕
                Button(action: {
                    viewModel.newGame()
                }) {
                    VStack { // 文字與圖示上下方式排列
                        Image(systemName: "arrow.triangle.2.circlepath.circle")
                            .font(.largeTitle)
                        Text("New Game")
                            .font(.caption) // 設定不同的大小
                    }
                }
            }
            .padding(.bottom)
        }
        .padding()
        // 依照目前選取的 Theme 設定整體顏色 (包含卡片背對顏色)
        .foregroundStyle(viewModel.themeColor)
    }
    
    var cardList: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
                ForEach(viewModel.cards) { card in
                    CardView(card: card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .padding(4)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                }
            }
        }
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            Group {
                shape.fill(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content)
                    .font(Font.system(size: 300))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            
            shape.opacity(card.isFaceUp ? 0 : 1)
            
        }
        .opacity(card.isMatched && !card.isFaceUp ? 0 : 1)
    }
}

#Preview {
    ContentView(viewModel: EmojiMemoryGame())
}
