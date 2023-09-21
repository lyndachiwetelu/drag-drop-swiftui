import Foundation

class MemoryGame: ObservableObject {
    @Published var items: [MemoryItem] = [
        MemoryItem(id:1, imageName: "pikachu", type: .pikachu),
        MemoryItem(id:2, imageName: "pikachu-1", type: .pikachu),
        MemoryItem(id:3, imageName: "mickey-1", type: .mickeymouse),
        MemoryItem(id:4, imageName: "mickey", type: .mickeymouse),
        MemoryItem(id:5, imageName: "spongebob", type: .spongebob),
        MemoryItem(id:6, imageName: "spongebob-1", type: .spongebob),
    ]
    
    @Published var itemsShown: [MemoryItem] = []
    var itemsWon: [Int] = []
    var startTime = Date()
    @Published var isWon = false
    
    init() {
        self.items.shuffle()
    }
    
    func startNew() {
        items.shuffle()
        resetAllItems()
        startTime = Date()
    }
    
    func play(lhi: MemoryItem, rhi: MemoryItem) {
        if lhi.type == rhi.type {
            itemsShown.append(contentsOf: [lhi, rhi])
            itemsWon.append(contentsOf: [lhi.id, rhi.id])
            checkWin()
        }
    }
    
    func checkWin() {
        isWon = itemsWon.count == items.count
    }
    
    func handleShow(_ i: MemoryItem) {
        let isShown = itemsShown.first { mi in
            mi.id == i.id
        }
        guard isShown == nil else { return }
        itemsShown.append(i)
        resetAllItems(i)
    }
    
    func resetAllItems() {
        itemsShown.removeAll()
        itemsWon.removeAll()
    }
    
    func resetAllItems(_ except: MemoryItem) {
        itemsShown.removeAll { item in
            item.id != except.id && !itemsWon.contains(item.id)
        }
    }
}
