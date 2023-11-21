//
//  Model.swift
//  HomePass
//
//  Created by Chuhan Qin on 2023-11-21.
//

import CoreData
import UIKit

@objc(HomePass)
public class HomePass: NSManagedObject, Identifiable {
    @NSManaged public var id: UUID // Unique identifier for each pass
    @NSManaged public var name: String // Name of the pass
    @NSManaged public var details: String? // Additional details
    @NSManaged public var imageData: Data? // Image data (optional)

    // Computed property to convert imageData to UIImage
    public var image: UIImage? {
        get {
            guard let imageData = imageData else { return nil }
            return UIImage(data: imageData)
        }
        set {
            imageData = newValue?.jpegData(compressionQuality: 1.0)
        }
    }

    // Convenience initializer
    convenience init(context: NSManagedObjectContext, name: String, details: String?, image: UIImage?) {
        self.init(context: context)
        self.id = UUID()
        self.name = name
        self.details = details
        self.image = image
    }
}
