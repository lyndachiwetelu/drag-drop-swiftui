//

import SwiftUI

struct WelcomeView: View {
    @Binding var navPaths: [String]
    
    var body: some View {
        VStack {
            Text("Memory Toony").font(.title2).padding(.top, 100).padding(.bottom, 20)
            Text("Welcome to the Memory Toony game. Drag a picture to a matching pair to win two points").padding(.bottom, 30)
            
            Image("pikachu").resizable().frame(width: 100, height: 100)
           
            Text("Game Instructions").font(.headline)
            VStack(alignment: .leading) {
                Text("You can tap a square to view the image").padding(3)
                Text("You can double tap an image to hide it, but viewing an image automatically hides all the others").padding(3)
                Text("Drag a displayed image to a hidden square to match").padding(3)
            }
            
            ButtonView(title: "Start Game") {
                navPaths.append("game")
            }
            
        }.padding(30)
        
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(navPaths: .constant([]))
    }
}
