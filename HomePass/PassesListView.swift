//
//  PassesListView.swift
//  HomePass
//
//  Created by Chuhan Qin on 2023-11-21.
//

import Foundation
import SwiftUI

struct PassesListView: View {
    @State private var passes: [HomePass] = []
    @State private var showingAddPassView = false
    
    var body: some View {
            NavigationView {
                Group {
                    if passes.isEmpty {
                        // Display a message when there are no passes
                        Text("No passes yet.")
                            .foregroundColor(.gray)
                            .opacity(0.5)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else {
                        // List of passes
                        List {
                            ForEach(passes, id: \.id) { pass in
                                PassRow(pass: pass)
                                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 0))
                            }
                            .onDelete(perform: deletePasses)
                        }
                        .backgroundStyle(.clear)
                    }
                }
                .navigationBarTitle("My Passes")
                .navigationBarItems(trailing: Button(action: {
                    showingAddPassView = true
                }) {
                    Image(systemName: "plus")
                })
            }
            .sheet(isPresented: $showingAddPassView) {
                AddPassView(onSave: { _ in
                    loadPasses()
                })
            }
            .onAppear {
                loadPasses()
            }
        }
    
    
    struct PassRow: View {
        let pass: HomePass

        var body: some View {
            ZStack(alignment: .bottomLeading) {
                // Image
                if let imageData = pass.imageData, let image = UIImage(data: imageData) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 200) // Adjust height as needed
                        .cornerRadius(15)
                        .clipped()
                }

                // Transparent gradient
                LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black.opacity(0.7)]), startPoint: .top, endPoint: .bottom)
                    .cornerRadius(15)

                // Text
                VStack(alignment: .leading) {
                    Text(pass.name)
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .trailing)
//                    Text(pass.details)
//                        .font(.subheadline)
//                        .foregroundColor(.white)
                }
                .padding()
            }
            .frame(height: 200) // Ensuring the ZStack has a fixed height
            .shadow(radius: 5)
            .padding(.horizontal)
        }
    }
    
    
    private var addButton: some View {
        Button(action: {
            // Placeholder action for adding a new pass
            // In a real app, this should navigate to a view for adding a new pass
            print("Add Pass Button Tapped")
        }) {
            Image(systemName: "plus")
        }
    }
    
    
    private func loadPasses() {
        passes = loadPassesFromUserDefaults()
    }
    
    private func deletePasses(at offsets: IndexSet) {
        passes.remove(atOffsets: offsets)
        savePassesToUserDefaults(passes)
    }
    
    private func loadPassesFromUserDefaults() -> [HomePass] {
        if let savedData = UserDefaults.standard.data(forKey: "HomePasses") {
            let decoder = JSONDecoder()
            if let loadedPasses = try? decoder.decode([HomePass].self, from: savedData) {
                return loadedPasses
            }
        }
        return []
    }
    
    private func savePassesToUserDefaults(_ passes: [HomePass]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(passes) {
            UserDefaults.standard.set(encoded, forKey: "HomePasses")
        }
    }
}


