
import SwiftUI

struct ConfettiView: View {
    @State private var isAnimating = false
    let text: String
    let textColor: Color
    let textSize: CGFloat
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.2)
            
            VStack {
                ForEach(0..<50) { _ in
                    ConfettiDash()
                }
            }
            
            Text(text)
                .font(.system(size: textSize, weight: .bold))
                .foregroundColor(textColor)
                .onAppear(){
                    withAnimation(.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                        isAnimating.toggle()
                    }
                }
                .scaleEffect(isAnimating ? 1.2 : 1.0)
        }
        .onAppear {
            startAnimating()
        }
        .onDisappear {
            stopAnimating()
        }
    }
    
    private func startAnimating() {
        isAnimating = true
    }
    
    private func stopAnimating() {
        isAnimating = false
    }
}

struct ConfettiDash: View {
    @State private var xOffset: CGFloat = .random(in: -100...100)
    @State private var yOffset: CGFloat = .random(in: -100...100)
    @State private var rotation: Double = .random(in: 0...360)
    
    let confettiColors: [Color] = [.red, .green, .blue, .orange, .purple, .pink]
    
    var body: some View {
        Rectangle()
            .fill(confettiColors.randomElement()!)
            .frame(width: 10, height: 2)
            .offset(x: xOffset, y: yOffset)
            .rotationEffect(Angle(degrees: rotation))
            .onAppear {
                withAnimation(.linear(duration: 2).repeatForever(autoreverses: false)) {
                    xOffset = .random(in: -100...100)
                    yOffset = .random(in: -100...100)
                    rotation = .random(in: 0...360)
                }
                
            }
    }
}

