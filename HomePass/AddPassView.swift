//
//  AddPassView.swift
//  HomePass
//
//  Created by Chuhan Qin on 2023-11-21.
//

import Foundation
import SwiftUI

struct AddPassView: View {
    @Environment(\.presentationMode) var presentationMode
        @State private var name: String = ""
        @State private var details: String = ""
        @State private var image: UIImage?
        @State private var showingImagePicker = false
        var onSave: ([HomePass]) -> Void  // Closure to be called after saving

        var body: some View {
            NavigationView {
                Form {
                    Section {
                        TextField("Name", text: $name)
                            .frame(height: 40)
                        TextField("Details", text: $details)
                            .frame(height: 40)
                    }
                    
                    Section {
                        if let image = image {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(height: 300) // Adjusted height for a larger image display
                        }
                    }
                    
                    Section {
                        Button("Choose Image") {
                            showingImagePicker = true
                        }
                        .frame(height: 40, alignment: .center)
                        
                    }

                    Section {
                        Button("Save", action: savePass)
                            .frame(height: 40, alignment: .center)
                    }
                }
                .navigationBarTitle("Add Pass", displayMode: .inline)
                .sheet(isPresented: $showingImagePicker) {
                    ImagePicker(image: $image)
                }
            }
        }

    private func savePass() {
        let newPass = HomePass(name: name, details: details, image: image)
        var currentPasses = loadPassesFromUserDefaults()
        currentPasses.append(newPass)
        savePassesToUserDefaults(currentPasses)
        onSave(currentPasses)
        presentationMode.wrappedValue.dismiss() // Dismiss the view
    }

    private func loadPassesFromUserDefaults() -> [HomePass] {
        // Your logic to load passes from UserDefaults
        loadPasses()
    }

    private func savePassesToUserDefaults(_ passes: [HomePass]) {
        // Your logic to save passes to UserDefaults
        savePasses(passes)
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    func makeUIViewController(context: Context) -> some UIViewController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }

            picker.dismiss(animated: true)
        }
    }
}
