//
//  AssignTaskIntent.swift
//  TaskFlow
//
import AppIntents
import SwiftUI
struct AssignTaskIntent: AppIntent, ForegroundContinuableIntent {
    static var title: LocalizedStringResource = "Assign Task"
    static var description = IntentDescription("Reassigns an existing TaskFlow task to a different teammate.")
    @Parameter(title: "Task")
    var task: TaskItem
    @Parameter(title: "Assignee")
    var assignee: Teammate?
    
    init() {}
    init(task: TaskItem, assignee: Teammate) {
        self.task = task
        
        self.assignee = assignee}
    func perform() async throws -> some IntentResult & ProvidesDialog & ShowsSnippetView {
        guard let finalAssignee = assignee else {
            try await requestToContinueInForeground()
            return .result(dialog: "No assignee was chosen, so nothing was reassigned.")
        }
        TasksStore.shared.reassign(task.id, to: finalAssignee)
        return .result(
            dialog: "Task reassigned.",
            view: AssignConfirmationSnippet(task: task, assignee: finalAssignee)
        )
    }
}
struct AssignConfirmationSnippet: View {
    let task: TaskItem
    let assignee: Teammate
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(task.title)
                .font(.headline)
            Text("Assigned to " + assignee.name)
                .foregroundStyle(.secondary)
            if let next = TasksStore.shared.teammates.first(where: { $0.id != assignee.id }) {
                Button(intent: AssignTaskIntent(task: task, assignee: next)) {
                    Text("Reassign to " + next.name)
                }
            }
        }
        .padding()
    }
}

