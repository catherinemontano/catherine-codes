//
//  ContentView.swift
//  War Card Game
//
//  Created by icy ;p on 6/13/25.
//  Tutorial from CodeWithChris

import SwiftUI

struct ContentView: View {
    @State var playerCard = "card7"
    @State var cpuCard = "card13"
    // @State is a property wrapper ---- changes the behaviour and attributes ---- powers the visual state
    
    @State var playerScore = 0
    @State var cpuScore = 0
    
    var body: some View {
        
        ZStack {
            Image("background-plain")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Image("logo")
                Spacer()
                
                HStack {
                    Spacer()
                    Image(playerCard)
                    Spacer()
                    Image(cpuCard)
                    Spacer()

                }
                Spacer()
                
                
                
                Button(action: {
                    deal()
                }, label: {
                    Image("button")
                })
                
                Spacer()
                HStack {
                    Spacer()
                    VStack {
                        Text("Player")
                            .font(.headline)
                            .padding(.bottom, 10.0)
                        Text(String(playerScore))
                            .font(.largeTitle)
                    }
                    Spacer()

                    VStack {
                        Text("CPU")
                            .font(.headline)
                            .padding(.bottom, 10.0)
                            Text(String(cpuScore))
                            .font(.largeTitle)
                    }
                    Spacer()
                }
                .foregroundColor(.white)
                Spacer()

            }

        }
    }
    
    func deal(){
            //Randomize the players card
        var playerCardValue = (Int.random(in: 2...14))
        playerCard = "card" + String(playerCardValue)
            //Randomize CPU card
        var cpuCardValue = (Int.random(in: 2...14))
        cpuCard = "card" + String(cpuCardValue)
            //Update the scores
        
        if playerCardValue > cpuCardValue {
            playerScore += 1
        } else if cpuCardValue > playerCardValue {
            cpuScore += 1
        }
    }

}


#Preview {
    ContentView()
}
