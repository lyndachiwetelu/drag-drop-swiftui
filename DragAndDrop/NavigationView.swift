//

import SwiftUI

struct NavigationView: View {
    @State var navPaths: [String] = []
    var body: some View {
        NavigationStack(path: $navPaths) {
            WelcomeView(navPaths: $navPaths)
                .navigationDestination(for: String.self) { r in
                switch r {
                case "game":
                    GameView().navigationBarBackButtonHidden(true)
                default:
                    WelcomeView(navPaths: $navPaths)
                }
            }
        }
    }
}

