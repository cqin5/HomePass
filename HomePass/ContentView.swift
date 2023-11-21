//
//  ContentView.swift
//  HomePass
//
//  Created by Chuhan Qin on 2023-11-21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    // Updated FetchRequest for Pass entities
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \HomePass.name, ascending: true)],
        animation: .default)
    private var passes: FetchedResults<HomePass>

    var body: some View {
        NavigationView {
            List {
                ForEach(passes) { pass in
                    NavigationLink {
                        Text("Pass: \(pass.name)")
                    } label: {
                        Text(pass.name)
                    }
                }
                .onDelete(perform: deletePasses)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addPass) {
                        Label("Add Pass", systemImage: "plus")
                    }
                }
            }
            Text("Select a pass")
        }
    }

    // Updated function to add a Pass
    private func addPass() {
        withAnimation {
            let newPass = HomePass(context: viewContext)
            newPass.id = UUID()
            newPass.name = "New Pass"
            // Set other properties of Pass as needed

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    // Updated function to delete Passes
    private func deletePasses(offsets: IndexSet) {
        withAnimation {
            offsets.map { passes[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

// You can update or remove this formatter based on the data you want to display.
private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

// Updated Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
