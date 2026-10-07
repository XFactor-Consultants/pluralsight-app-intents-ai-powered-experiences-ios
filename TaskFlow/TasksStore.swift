import SwiftUI

@Observable
final class TasksStore {
    static let shared = TasksStore()
    private(set) var tasks: [TaskItem]
    let teammates: [Teammate]

    init() {
        let priya = Teammate(id: UUID(uuidString: "11111111-1111-1111-1111-111111111111")!, name: "Priya Raman")
        let marcus = Teammate(id: UUID(uuidString: "11111111-1111-1111-1111-111111111112")!, name: "Marcus Webb")
        let dana = Teammate(id: UUID(uuidString: "11111111-1111-1111-1111-111111111113")!, name: "Dana Ortiz")
        teammates = [priya, marcus, dana]

        let day: TimeInterval = 60 * 60 * 24
        tasks = [
            TaskItem(
                id: UUID(uuidString: "22222222-2222-2222-2222-222222222221")!,
                title: "Update emergency contact info",
                notes: "HR needs current emergency contacts on file before the offsite. Includes home address and phone numbers.",
                assignee: priya,
                dueDate: .now.addingTimeInterval(2 * day),
                priority: .high,
                isSensitive: true
            ),
            TaskItem(
                id: UUID(uuidString: "22222222-2222-2222-2222-222222222222")!,
                title: "Prepare sprint demo",
                notes: "Walk through the new filtering flow. Keep it under ten minutes.",
                assignee: marcus,
                dueDate: .now.addingTimeInterval(1 * day),
                priority: .high
            ),
            TaskItem(
                id: UUID(uuidString: "22222222-2222-2222-2222-222222222223")!,
                title: "Rotate shared server credentials",
                notes: "Quarterly rotation. Update the shared vault entry and notify the on-call channel.",
                assignee: dana,
                dueDate: .now.addingTimeInterval(5 * day),
                priority: .medium,
                isSensitive: true
            ),
            TaskItem(
                id: UUID(uuidString: "22222222-2222-2222-2222-222222222224")!,
                title: "Review Q3 roadmap draft",
                notes: "Leave comments directly in the doc before Thursday's planning meeting.",
                assignee: priya,
                dueDate: .now.addingTimeInterval(-1 * day),
                priority: .medium
            ),
            TaskItem(
                id: UUID(uuidString: "22222222-2222-2222-2222-222222222225")!,
                title: "Book venue for team offsite",
                notes: "Need space for twelve, projector, and decent coffee nearby.",
                assignee: dana,
                dueDate: .now.addingTimeInterval(9 * day),
                priority: .low
            ),
            TaskItem(
                id: UUID(uuidString: "22222222-2222-2222-2222-222222222226")!,
                title: "Fix onboarding flow copy",
                notes: "Second screen still says \"beta\" — swap in the approved wording.",
                assignee: marcus,
                dueDate: .now.addingTimeInterval(3 * day),
                priority: .low
            ),
            TaskItem(
                id: UUID(uuidString: "22222222-2222-2222-2222-222222222227")!,
                title: "Send weekly status update",
                notes: "Same format as last week. Include the demo recording link.",
                assignee: priya,
                dueDate: .now.addingTimeInterval(-2 * day),
                priority: .medium,
                isComplete: true
            )
        ]
    }

    func task(id: UUID) -> TaskItem? {
        tasks.first { $0.id == id }
    }

    func toggleComplete(_ task: TaskItem) {
        guard let index = tasks.firstIndex(where: { $0.id == task.id }) else { return }
        tasks[index].isComplete.toggle()
    }
    func addTask(_ task: TaskItem) {
        tasks.append(task)
    }
    func reassign(_ taskID: TaskItem.ID, to teammate: Teammate) {
        guard let index = tasks.firstIndex(where: { $0.id == taskID }) else { return }
        tasks[index].assignee = teammate
    }
}
