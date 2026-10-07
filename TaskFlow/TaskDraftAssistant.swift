//
//  TaskDraftAssistant.swift
//  TaskFlow
//
import FoundationModels

enum TaskDraftAssistant {
    static func draftTask(from roughDescription: String) async throws -> TaskDraft {
        let session = LanguageModelSession(
            instructions: "Turn a rough, free-text task description into a clean task title and a suggested assignee name, drawing only from the text given."
        )
        let response = try await session.respond(to: roughDescription, generating: TaskDraft.self)
        return response.content
    }
}
