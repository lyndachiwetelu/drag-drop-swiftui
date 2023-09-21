//

import SwiftUI

struct ButtonView: View {
    let title: String
    let action:  () -> Void
    var body: some View {
        Button(action: {
           action()
        }) {
            Text(title)
                .foregroundColor(.black)
                .padding()
                .frame(width: 200)
                .background(Color(UIColor.lightGray))
                .cornerRadius(12)
        }
        .padding(.bottom, 20).padding(.top, 40)
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(title: "Start Game") {
            
        }
    }
}
