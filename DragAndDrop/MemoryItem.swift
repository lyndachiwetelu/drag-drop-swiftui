import Foundation
import SwiftUI
import UniformTypeIdentifiers

enum MemoryItemType: Codable {
    case pikachu
    case spongebob
    case mickeymouse
}

struct MemoryItem: Codable, Equatable {
    let id: Int
    let imageName: String
    let type: MemoryItemType
    
    init(id: Int, imageName: String, type: MemoryItemType) {
        self.id = id
        self.imageName = imageName
        self.type = type
    }
}

extension MemoryItem: Transferable {
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .memoryItem)
    }

}

extension UTType {
    static var memoryItem: UTType {
        UTType(importedAs: "com.draganddrop.memoryItem")
    }
}



