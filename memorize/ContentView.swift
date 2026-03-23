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
    var emojis = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    
    @State var emojiCount = 8
    
    var body: some View {
        VStack{
            HStack{
                ForEach(emojis[0..<emojiCount], id: \.self) { emoji in
                    CardView(content:emoji)
                }
            }
            
            HStack{
                remove
                Spacer()
                add
            }
            .font(.largeTitle)
        }
        .padding()
        .foregroundStyle(.orange)
    }
    var remove:some View{
        Button{
            if emojiCount > 1{
                emojiCount -= 1
            }
        } label:{
            Image(systemName:"minus.circle")
        }
        
    }
    var add:some View{
        Button{
            if emojiCount < emojis.count{
                emojiCount += 1
            }
        } label:{
            Image(systemName:"plus.circle")
        }
        
    }
}

struct CardView: View{
    @State var isFaceUp: Bool = true
    var content: String
    var body: some View{
        ZStack{
            let shape:RoundedRectangle = RoundedRectangle(cornerRadius: 20)
            //var shape = Circle()
            if isFaceUp{
                shape.fill(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            }
            else{
                shape
            }
        }
        .onTapGesture{isFaceUp = !isFaceUp}
        //.onTapGesture(perform: {isFaceUp = !isFaceUp})
    }
}
#Preview {
    ContentView()
}
