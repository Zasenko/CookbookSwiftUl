//
//  ToDoList.swift
//  Cookbook SwiftUI
//
//  Created by Dmitry Zasenko on 24.05.24.
//

import SwiftUI

struct ToDoList: View {
    @State var tasks = Task.tasks
       var body: some View {
           TaskListView(tasks: $tasks)
       }
}

#Preview {
    ToDoList()
}

struct TaskListView: View {
    @Binding var tasks: [Task]
    var body: some View {
        NavigationStack {
            List {
                ForEach($tasks) { task in
                    TaskView(task: task)
                }
            }.navigationTitle(Text("To do list"))
        }
    }
}

struct TaskView: View {
    @Binding var task: Task
    var body: some View {
        HStack {
            Image(systemName: task.completed ? "checkmark.circle.fill" : "circle")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(task.completed ? Color(UIColor.systemBlue) : Color.secondary)
                        .onTapGesture {
                            self.task.completed.toggle()
                        }

            Text(task.description)
                .font(.title2)
                .padding()
            Spacer()
        }.padding()
    }
}

enum Priority: Comparable {
    case high
    case medium
    case low
}

struct Task: Identifiable {
    var id = UUID()
    var completed: Bool
    var description: String
    var priority: Priority
}

extension Task {
    static var tasks = [
        Task(completed: false, description: "Wake up", priority: .low ),
        Task(completed: false, description: "Shower", priority: .medium),
        Task(completed: false, description: "Code", priority: .high),
        Task(completed: false, description: "Eat", priority: .high ),
        Task(completed: false, description: "Sleep", priority: .high),
        Task(completed: false, description: "Get groceries", priority: .high)
    ]
    static var task = tasks[0]
}
