//
//  ContentView.swift
//  Dice
//
//  Created by Jack Xia on 18/09/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State var leftDiceN = 1
    @State var rightDiceN = 1
    
    var body: some View {
        
        ZStack() {
            Image("background")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Image("diceeLogo")
                
                Spacer()
                
                HStack {
                    DiceView(n: leftDiceN)
                    DiceView(n: rightDiceN)
                }
                .padding(.horizontal)
                
                Spacer()
                
                Button(action: {
                    // Closure using self to be explicit
                    self.leftDiceN = Int.random(in: 1...6)
                    self.rightDiceN = Int.random(in: 1...6)
                }) {
                    // Returns a View
                    Text("Roll")
                        .font(.system(size: 50))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .padding()
                }
                .background(Color.red)
                
                
            }
        }
        
    }
}

struct DiceView: View {
    let n: Int
    var body: some View {
        Image("dice\(n)")
            .resizable()
            .aspectRatio(1, contentMode: .fit )
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


