import SwiftUI

struct GameView: View {
    @StateObject private var game: MemoryGame = MemoryGame()
    
    @State var itemsShown = [MemoryItem]()
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var timeElaspsed = "00.00"
    @State var showConfetti = false
    
    var body: some View {
        
        ZStack {
            VStack {
                HStack {
                    Spacer()
                    Text("Memory Toony").font(.headline)
                    Spacer()
                    Text("\(timeElaspsed)").font(.title3).onReceive(timer) { input in
                        timeElaspsed = game.startTime.timeBetween(date: Date())
                    }
                }.padding(.leading, 40).padding(.trailing, 40).padding(.bottom, 30)
                
                
                
                LazyVGrid(columns: [GridItem(), GridItem()], spacing: 30) {
                    
                    ForEach(game.items, id: \.imageName) { item in
                        
                        HStack {
                            
                            Image(item.imageName).resizable().frame(width: 150, height: 150)
                                .aspectRatio(contentMode: .fit)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color(UIColor.lightGray), lineWidth: 2)
                                )
                                .draggable(item) {
                                    Image(item.imageName).resizable().frame(width: 70, height: 70).cornerRadius(10).opacity(0.5)
                                }
                                .opacity(isItemShown(item) ? 1 : 0)
                            
                        }.frame(width: 150, height: 150).background(Color(UIColor.lightGray).opacity(0.5)).cornerRadius(10).onTapGesture(count: 1) {
                            game.handleShow(item)
                        }.dropDestination(for: MemoryItem.self) { items, _ in

                            let draggedItem = items.first
                            guard draggedItem != nil else { return true }
                            
                            game.play(lhi: item, rhi: draggedItem!)
                            
                            return true
                        }

                        
                    }
                   
                }
                
                ButtonView(title: "Start New Game") {
                    game.startNew()
                    timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                }
                
           
            }
            .padding(30)
            
            if showConfetti {
                ConfettiView(text: "You won!", textColor: .white, textSize: 24)
                    .onAppear {
                        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { _ in
                            showConfetti = false
                        }
                    }
            }
            
            
        }.onChange(of: game.itemsShown) { newValue in
            itemsShown = newValue
        }.onChange(of: game.isWon, perform: { newValue in
            if newValue {
                showConfetti = true
                timer.upstream.connect().cancel()
            }
        })
        .onAppear() {
            game.startNew()
        }
    }
    
    func isItemShown(_ i: MemoryItem) -> Bool {
        return itemsShown.contains { item in
            item.imageName == i.imageName
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
