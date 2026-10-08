import SwiftUI
import FoundationModels

struct SettingsView: View {
    @Environment(TasksStore.self) private var tasksStore
    #if DEBUG
    @State private var draftResult: TaskDraft?
    @State private var breakdown: SubtaskBreakdown.PartiallyGenerated?
    #endif

    var body: some View {
        NavigationStack {
            Form {
                Section("Workspace") {
                    LabeledContent("Open Tasks", value: "\(tasksStore.tasks.filter { !$0.isComplete }.count)")
                    LabeledContent("Teammates", value: "\(tasksStore.teammates.count)")
                }
                Section("Team") {
                    ForEach(tasksStore.teammates) { teammate in
                        HStack {
                            Text(teammate.initials)
                                .font(.caption)
                                .padding(6)
                                .background(.quaternary, in: Circle())
                            Text(teammate.name)
                        }
                    }
                }
                Section("About") {
                    LabeledContent("Version", value: "1.0 (canonical build)")
                }
                #if DEBUG
                if case .available = SystemLanguageModel.default.availability {
                    Section("AI Task Drafting (Debug)") {
                        Text("Somebody needs to get the sprint demo ready by Thursday, probably Marcus.")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                        Button("Generate Draft") {
                            Task {
                                draftResult = try? await TaskDraftAssistant.draftTask(from: "Somebody needs to get the sprint demo ready by Thursday, probably Marcus.")
                            }
                        }
                        if let draftResult {
                            Text("Title: " + draftResult.title)
                            Text("Assignee: " + draftResult.suggestedAssigneeName)
                        }
                    }
                    Section("AI Subtask Breakdown (Debug)") {
                        Button("Stream Subtask Breakdown") {
                            Task {
                                do {
                                    for try await partial in try SubtaskAssistant.streamBreakdown(for: "Plan the team offsite") {
                                        breakdown = partial.content
                                    }
                                } catch {
                                    breakdown = nil
                                }
                            }
                        }
                        if let breakdown {
                            if let subtasks = breakdown.subtasks {
                                ForEach(subtasks, id: \.self) { Text("• \($0)") }
                            }
                            if let suggestedOwner = breakdown.suggestedOwner {
                                Text("Suggested owner: \(suggestedOwner)")
                                    .bold()
                            }
                        }
                    }
                } else {
                    Section("AI Features (Debug)") {
                        Text("AI drafting isn't available on this device right now. Create the task manually instead.")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }
                }
                Section("Prompt Safety (Debug)") {
                    Button("Print Prompt-Safe Titles") {
                        print("All titles:", TasksStore.shared.tasks.map { $0.title })
                        print("Prompt-safe titles:", TasksStore.shared.promptSafeTasks.map { $0.title })
                    }
                }
                #endif
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
        .environment(TasksStore())
}
