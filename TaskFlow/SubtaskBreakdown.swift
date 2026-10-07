//
//  SubtaskBreakdown.swift
//  TaskFlow
//
import FoundationModels
@Generable
struct SubtaskBreakdown {
    @Guide(description: "3 to 6 short, actionable subtasks that break the larger task into concrete steps")
    var subtasks: [String]
    @Guide(description: "The teammate best suited to own the first subtask, chosen using current workload")
    var suggestedOwner: String
}
