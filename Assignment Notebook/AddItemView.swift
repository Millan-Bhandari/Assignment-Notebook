//
//  AddItemView.swift
//  Assignment Notebook
//
//  Created by Millan Bhandari on 7/25/22.
//

import SwiftUI

struct AddItemView: View {
    @ObservedObject var assignmentItem : AssignmentItems
    @State private var courses = ""
    @State private var description = ""
    @State private var dueDate = Date()
    @Environment(\.presentationMode) var presentationMode
    static let courses = ["English", "Science", "Math"]
    var body: some View {
        NavigationView {
            Form {
                Picker("Courses", selection: $courses) {
                    ForEach(Self.courses, id: \.self) { courses in
                        Text(courses)
                    }
                }
                TextField("Description", text: $description)
                DatePicker("Due Date", selection: $dueDate)
            }
            .navigationBarTitle("Add New Assignment", displayMode: .inline)
            
            
            .navigationBarItems(trailing: Button("Save") {
                if courses.count > 0 && description.count > 0 {
                    let item = AssignmentItem(id: UUID(), course: courses,
                                               description: description, dueDate: dueDate)
                    assignmentItem.items.append(item)
                    presentationMode.wrappedValue.dismiss()
                }
            })
        }
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView(assignmentItem : AssignmentItems())
    }
}
