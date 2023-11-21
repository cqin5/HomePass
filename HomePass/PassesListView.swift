//
//  PassesListView.swift
//  HomePass
//
//  Created by Chuhan Qin on 2023-11-21.
//

import Foundation
import SwiftUI

struct PassesListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \HomePass.name, ascending: true)],
        animation: .default)
    private var passes: FetchedResults<HomePass>

    var body: some View {
        NavigationView {
            List {
                ForEach(passes) { pass in
                    HStack {
                        // Assuming you have a computed property to convert imageData to UIImage
                        if let image = UIImage(data: pass.imageData ?? Data()) {
                            Image(uiImage: image)
                                .resizable()
                                .frame(width: 50, height: 50)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        VStack(alignment: .leading) {
                            Text(pass.name)
                                .font(.headline)
                            if let details = pass.details {
                                Text(details)
                                    .font(.subheadline)
                            }
                        }
                    }
                }
                .onDelete(perform: deletePasses)
            }
            .navigationBarTitle("Passes")
            .navigationBarItems(trailing: Button(action: {
                // Implement navigation to Add Pass View
            }) {
                Image(systemName: "plus")
            })
        }
    }

    private func deletePasses(offsets: IndexSet) {
        withAnimation {
            offsets.map { passes[$0] }.forEach(viewContext.delete)
            PersistenceController.shared.saveContext()
        }
    }
}

