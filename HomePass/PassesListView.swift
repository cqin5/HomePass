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

    var body: some View {
        NavigationView {
            List {
                ForEach(passes, id: \.id) { pass in
                    HStack {
                        if let image = UIImage(data: pass.imageData ?? Data()) {
                            Image(uiImage: image)
                                .resizable()
                                .frame(width: 50, height: 50)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        VStack(alignment: .leading) {
                            Text(pass.name)
                                .font(.headline)
                            let details = pass.details
                            Text(details)
                                .font(.subheadline)
                            
                        }
                    }
                }
                .onDelete(perform: deletePasses)
            }
            .navigationBarTitle("My Passes")
            .navigationBarItems(trailing: Button(action: {
                // Implement navigation to Add Pass View
            }) {
                Image(systemName: "plus")
            })
            .onAppear {
                loadPasses()
            }
        }
    }

    private func loadPasses() {
        passes = loadPassesFromUserDefaults()
//        let _ = ForEach(passes, id: \.id) { pass in
//            HStack {
//                if let imageData = pass.imageData, let image = UIImage(data: imageData) {
//                    Image(uiImage: image)
//                        .resizable()
//                        .frame(width: 50, height: 50)
//                        .clipShape(RoundedRectangle(cornerRadius: 10))
//                }
//                VStack(alignment: .leading) {
//                    Text(pass.name)
//                        .font(.headline)
//                    Text(pass.details)
//                        .font(.subheadline)
//                }
//            }
//        }
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


