//
//  ContentView.swift
//  ProgrammaticCoreData
//
//  Created by Kamaal M Farah on 13/11/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @State private var items: [Item] = []

    var body: some View {
        NavigationView {
            List {
                if items.isEmpty {
                    Text("No items yet")
                }
                ForEach(items, id: \.id) { item in
                    Text(dateFormatter.string(from: item.timestamp))
                }
            }
            .navigationTitle("Programmatic CD")
            .toolbar { ToolbarItem(placement: .navigationBarTrailing) { toolbarView } }
        }
        .onAppear(perform: { fetchItems() })
    }

    private var toolbarView: some View {
        Button(action: addItem) {
            Image(systemName: "plus")
        }
    }

    private func addItem() {
        let item = Item(context: viewContext)
        item.timestamp = Date()
        item.id = UUID()

        do {
            try viewContext.save()
        } catch {
            print("error", error)
            return
        }

        withAnimation { items = [item] + items }
    }

    private func fetchItems() {
        let request = Item.fetchRequest()
        let result: [Item]
        do {
            result = try viewContext.fetch(request)
        } catch {
            print("error", error)
            return
        }

        withAnimation { items = result.reversed() }
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
