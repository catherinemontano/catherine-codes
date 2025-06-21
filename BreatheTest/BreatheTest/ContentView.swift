//
//  ContentView.swift
//  BreatheTest
//
//  Created by icy ;p on 6/14/25.
// random idea on a saturday morning
// take a breath. take it slow.

import SwiftUI

struct ContentView: View {
    @State private var currentQuote = ""
    @State private var isRunning = false
    @State private var scale: CGFloat = 1
    @State private var counter = 1
    @State private var timer: Timer? = nil
    @State private var breathCycle = 0
    @State private var isInhaling = true
    @State private var isEnd = false
    @State private var endMessage = ""
    
    
    let totalBreath =  2
    
    
    var body: some View {
        ZStack{
            Color.purple
            
            VStack {
                HStack {
                    Text(isEnd ? endMessage : currentQuote)
                        .fontWeight(.bold)
                        .font(.system(size:42))
                        .animation(.easeIn)
                }
                
                Circle()
                    .foregroundColor(.white)
                    .frame(width: 100, height: 100)
                    .scaleEffect(scale)
                    .animation(.easeInOut(duration: 3), value: scale)
                
                Text(isInhaling ? "Inhaling" : "Exhaling")
                
                
                Button(action: {
                    isRunning.toggle()
                    
                    if isRunning {
                        startBreathing()
                    } else {
                        stopBreathing()
                        
                    }
                }){
                    Text(isRunning ? "Stop" : "Start")
                        .padding()
                }
                
                Text("Cycle " + String( breathCycle ) + " of 7")
                
            }
            .padding()
            .onAppear {
                currentQuote = getRandomQuote()
                endMessage = getEndMessage()
            }
        }
    }
    
    
    let quotes = [
        "This moment is enough.",
        "You are coming home to yourself.",
        "You are doing the best you can.",
    ]
    
    func getRandomQuote() -> String {
        return quotes.randomElement() ?? "Take a moment."
    }
    
    //working on this part
    func startBreathing() {
        scale = 1.5
        breathCycle = 0
        isInhaling = true
        
        timer = Timer.scheduledTimer(withTimeInterval: 4.0, repeats: true) { _ in
            withAnimation(.easeInOut(duration: 4)) {
                scale = isInhaling ? 1.0 : 1.5
            }
            
            if !isInhaling {
                // Complete cycle only after exhale
                breathCycle += 1
            }
            
            if breathCycle >= totalBreath {
                stopBreathing()
            }
            
            isInhaling.toggle()
            print(breathCycle)
        }
    }
    
    func stopBreathing(){
        timer?.invalidate()
        timer = nil // a bit confused for this one
        isRunning = false
        counter = 1
        scale = 1.0
        
        if breathCycle >= totalBreath {
            isEnd = true
            endMessage = getEndMessage()
        }
        
    }
    let endQuote  = [
        "Peace looks good on you",
        "You did it. Be proud.",
        "Back to the world, but softer"
    ]
    
    func getEndMessage() -> String {
        return endQuote.randomElement() ?? "end lol"
    }
}
 
    #Preview {
        ContentView()
    }


// sound
// components / assets
// style it out

