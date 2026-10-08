import AppIntents
import SwiftUI

struct SuggestSubtasksIntent: AppIntent {
    static var title: LocalizedStringResource = "Suggest Subtasks"
    static var description = IntentDescription("Suggests a subtask breakdown and an owner for a larger task, without creating anything yet.")

    @Parameter(title: "Task Description")
    var taskDescription: String

    func perform() async throws -> some IntentResult & ProvidesDialog & ShowsSnippetView {
        let breakdown = try await SubtaskAssistant.breakdown(for: taskDescription)
        return .result(
            dialog: "Here's a suggested breakdown.",
            view: SubtaskSuggestionSnippet(breakdown: breakdown)
        )
    }
}

struct SubtaskSuggestionSnippet: View {
    let breakdown: SubtaskBreakdown

    var resolvedOwner: Teammate? {
        TasksStore.shared.teammates.first {
            $0.name.localizedCaseInsensitiveCompare(breakdown.suggestedOwner) == .orderedSame
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(breakdown.subtasks, id: \.self) { subtask in
                Text("• " + subtask)
            }
            if let resolvedOwner {
                Text("Suggested owner: " + resolvedOwner.name)
                    .bold()
                Button(intent: CreateSubtasksIntent(subtasks: breakdown.subtasks, ownerName: resolvedOwner.name)) {
                    Text("Confirm and Create")
                }
            } else {
                Text(breakdown.suggestedOwner + " doesn't match anyone on the team.")
                    .foregroundStyle(.red)
                ForEach(TasksStore.shared.teammates) { teammate in
                    Button(intent: CreateSubtasksIntent(subtasks: breakdown.subtasks, ownerName: teammate.name)) {
                        Text("Assign to " + teammate.name + " instead")
                    }
                }
            }
        }
        .padding()
    }
}
