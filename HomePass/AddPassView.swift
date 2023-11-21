//
//  AddPassView.swift
//  HomePass
//
//  Created by Chuhan Qin on 2023-11-21.
//

import Foundation
import SwiftUI

struct AddPassView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var name: String = ""
    @State private var details: String = ""
    @State private var image: UIImage?
    // ... other state variables for form fields

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                TextField("Details", text: $details)
                // Image Picker Here
                Button("Save", action: savePass)
            }
            .navigationBarTitle("Add Pass", displayMode: .inline)
        }
    }

    private func savePass() {
        let newPass = HomePass(name: name, details: details, image: image)
        
        // Handle navigation back to the list
    }
}
