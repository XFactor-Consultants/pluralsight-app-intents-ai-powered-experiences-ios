//
//  CreateSubtasksIntent.swift.swift
//  TaskFlow
//
import AppIntents

struct CreateSubtasksIntent: AppIntent {
    static var title: LocalizedStringResource = "Create Subtasks"
    static var description = IntentDescription("Creates and assigns a confirmed set of subtasks.")
    @Parameter(title: "Subtasks")
    var subtasks: [String]
    @Parameter(title: "Owner Name")
    var ownerName: String
    
    init() {}
    init(subtasks: [String], ownerName: String) {
        self.subtasks = subtasks
        
        self.ownerName = ownerName
        
    }
    func perform() async throws -> some IntentResult & ProvidesDialog {
        guard let owner = TasksStore.shared.teammates.first(where: {
            $0.name.localizedCaseInsensitiveCompare(ownerName) == .orderedSame
            
        }) else {
            return .result(dialog: "Couldn't confirm an owner, so nothing was created.")
        }
        for title in subtasks {
            TasksStore.shared.addTask(TaskItem(title: title, assignee: owner))
        }
        return .result(dialog: "Subtasks created.")
    }
}
