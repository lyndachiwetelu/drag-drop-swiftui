//

import Foundation

extension Date {
    func timeBetween(date: Date) -> String {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.minute, .second], from: self, to: date)
        
        if let minutes = components.minute, let seconds = components.second {
            return String(format: "%02d:%02d", minutes, seconds)
        } else {
            return "00:00"
        }
    }
}
