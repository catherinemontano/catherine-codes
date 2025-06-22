//
//  ContentView.swift
//  BreatheTest
//
//  Created by Catherine Montano on 6/14/25.
// random idea on a saturday morning
// take a breath. take it slow.

import SwiftUI
import AVFoundation

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
    @State private var audioPlayer: AVAudioPlayer?
    
    
    
    let totalBreath =  2
    
    
    var body: some View {
        ZStack{
            Image("background-image")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                
            
            VStack {
                HStack {
                    Spacer(minLength: 16)
                    Text(isEnd ? endMessage : currentQuote)
                        .font(.title)
                        .fontWeight(.semibold)
                        .animation(.easeIn)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(10)
                        .shadow(radius: 5)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                        .frame(maxWidth: 250)
                    Spacer(minLength: 16)
                }
                Spacer()
                
               
                    ZStack {
                        Circle()
                            .foregroundColor(Color(red: 1.0, green: 0.8, blue: 0.9).opacity(0.3).opacity(0.90))
                            .overlay(
                                Circle().stroke(Color(red: 1.0, green: 0.8, blue: 0.9).opacity(1), lineWidth: 1)
                            )
                            .blur(radius: 10)
                            .overlay(
                                Circle().stroke(Color.white.opacity(0.75), lineWidth: 3)
                            )
                            .blur(radius: 10)
                           
                    }
                    .background(.ultraThinMaterial)
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .scaleEffect(scale)
                    .animation(.easeInOut(duration: 3), value: scale)
                Spacer()
                
                Text(isInhaling ? "Inhaling" : "Exhaling")
                
                Spacer()
                
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
                Spacer()
                
                Text("Cycle " + String( breathCycle ) + " of 7")
                Spacer()
                
            }
            .padding()
            .onAppear {
                currentQuote = getRandomQuote()
                endMessage = getEndMessage()
                //playBackgroundAudio()
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
        timer = nil
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
    
   /* func playBackgroundAudio() {
        guard let sound = Bundle.main.url(forResource: "calm", withExtension: "wav") else {
            print("Audio file not found")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: sound)
            audioPlayer?.numberOfLoops = -1
            audioPlayer?.volume = 0.1
            audioPlayer?.play()
        } catch {
            print("Failed to play audio: \(error.localizedDescription)")
        }
    }
    */
}
 
    #Preview {
        ContentView()
    }


// sound -- background and inhale and exhale
// components / assets
// style it out
// add haptics

// next project: social media clone
// lemon8?

