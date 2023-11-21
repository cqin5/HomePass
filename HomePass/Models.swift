//
//  Model.swift
//  HomePass
//
//  Created by Chuhan Qin on 2023-11-21.
//

import CoreData
import UIKit

struct HomePass: Codable, Identifiable {
    let id: UUID
    var name: String
    var details: String
    var imageData: Data?
    
    init(name: String, details: String, image: UIImage?) {
        self.id = UUID()
        self.name = name
        self.details = details
        self.imageData = image?.jpegData(compressionQuality: 1.0) // Convert UIImage to Data
    }
}

func savePasses(_ passes: [HomePass]) {
    let encoder = JSONEncoder()
    if let encoded = try? encoder.encode(passes) {
        UserDefaults.standard.set(encoded, forKey: "HomePasses")
    }
}

func loadPasses() -> [HomePass] {
    let decoder = JSONDecoder()
    if let savedData = UserDefaults.standard.object(forKey: "HomePasses") as? Data {
        if let loadedPasses = try? decoder.decode([HomePass].self, from: savedData) {
            return loadedPasses
        }
    }
    return []
}
