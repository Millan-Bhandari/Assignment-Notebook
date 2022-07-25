//
//  ContentView.swift
//  Assignment Notebook
//
//  Created by Millan Bhandari on 7/25/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var assignmentItem = AssignmentItems()
    @State private var showingAddItemView = false
    var body: some View {
        NavigationView {
            List {
                ForEach(assignmentItem.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.course)
                                .font(.headline)
                            Text(item.description)
                        }
                        Spacer()
                        Text(item.dueDate, style: .date)
                    }
                }
                .onMove { indices, newOffset in
                    assignmentItem.items.move(fromOffsets: indices, toOffset: newOffset)
                }
                .onDelete{ indexSet in
                    assignmentItem.items.remove(atOffsets: indexSet)
                }
            }
            .sheet(isPresented: $showingAddItemView, content: {
               AddItemView(assignmentItem: assignmentItem)
           })
            .navigationBarItems(leading: EditButton())
            .navigationBarTitle("Assignments",  displayMode: .inline)
        }
    }
}

struct AssignmentItem: Identifiable, Codable {
    var id = UUID()
    var course = String()
    var description = String()
    var dueDate = Date()
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
