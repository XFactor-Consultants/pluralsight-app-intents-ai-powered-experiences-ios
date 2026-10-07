//
//  TeammateWorkloadTool.swift
//  TaskFlow
//
import FoundationModels
struct TeammateWorkloadTool: Tool {
    let name = "teammateWorkload"
    let description = "Reports how many tasks are currently assigned to each teammate, by name."

    @Generable
    struct Arguments { }

    func call(arguments: Arguments) async throws -> String {
        let store = TasksStore.shared
        let counts = store.teammates.map { teammate in
            let count = store.tasks.filter { $0.assignee?.id == teammate.id }.count
            return "\(teammate.name): \(count) tasks"
        }.joined(separator: ", ")
        return counts
    }
}
