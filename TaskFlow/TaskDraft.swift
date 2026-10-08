//
//  TaskDraft.swift
//  TaskFlow
//
import FoundationModels
@Generable
struct TaskDraft {
    @Guide(description: "A short, clear task title, 3 to 8 words")
    var title: String
    @Guide(description: "The most plausible teammate name mentioned or implied in the description, or an empty string if none is implied")
    var suggestedAssigneeName: String
}
extension TaskDraft {
    var isValid: Bool {
        let trimmed = title.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.count >= 3
    }
}

