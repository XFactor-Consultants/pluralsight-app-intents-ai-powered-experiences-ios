//
//  TaskFlowShortcuts.swift
//  TaskFlow
//
import AppIntents
struct TaskFlowShortcuts: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: CreateTaskIntent(),
            phrases: [
                "Create a task in \(.applicationName)",
                "Add a task to \(.applicationName)"
            ],
            shortTitle: "Create Task",
            systemImageName: "plus.circle"
        )
    }
}
