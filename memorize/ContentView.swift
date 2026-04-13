//
//  ContentView.swift
//  memorize
//
//  Created by 11344153 on 2026/3/16.
//

import SwiftUI

struct ContentView: View {
    //var emojis:Array<String> = ["A","A","A","A"]
    //var emojis:[String]= ["A","A","A","A"]
    //var emojis = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","牛","狗"]
    
    var viewModel:EmojiMemoryGame
    
    var body: some View {
        VStack{
            cardList
                .animation(.default, value: viewModel.cards)
            Spacer()
            Button("Shuffle"){
                viewModel.shuffle()
            }
            .font(.largeTitle)
        }
        .padding()
        .foregroundStyle(.orange)
    }
    
    var cardList: some View {
        ScrollView{
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 85),spacing: 0)],spacing: 0){
                ForEach(viewModel.cards) { card in
                    CardView(card:card)
                        .aspectRatio(2/3,contentMode: .fit)
                        .padding(4)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                }
            }
        }
    }
}

struct CardView: View{
    var card:MemoryGame<String>.Card
    var body: some View{
        ZStack{
            let shape = RoundedRectangle(cornerRadius: 20)
            //var shape = Circle()
            Group{
                shape.fill(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content)
                    .font(Font.system(size:300))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1,contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            
            shape.opacity(card.isFaceUp ? 0 : 1)
            
        }
        .opacity(card.isMatched && !card.isFaceUp ? 0 : 1)
    }
}
#Preview {
    ContentView(viewModel:EmojiMemoryGame())
}
