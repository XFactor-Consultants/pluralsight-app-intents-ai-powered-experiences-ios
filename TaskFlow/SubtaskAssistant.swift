//
//  SubtaskAssistant.swift
//  TaskFlow
//
import FoundationModels

enum SubtaskAssistant {
    static func streamBreakdown(for taskDescription: String) throws -> LanguageModelSession.ResponseStream<SubtaskBreakdown> {
        guard case .available = SystemLanguageModel.default.availability else {
            throw TaskAssistantError.modelUnavailable
        }

        let session = LanguageModelSession(
            tools:  [],
            instructions: "Break the given task into 3 to 6 concrete subtasks, and suggest which teammate should own the first one. Use the teammateWorkload tool to account for who currently has the least on their plate before choosing."
        )
        return session.streamResponse(to: taskDescription, generating: SubtaskBreakdown.self)
    }

    static func streamBreakdownWithoutTool(for taskDescription: String) throws -> LanguageModelSession.ResponseStream<SubtaskBreakdown> {
        guard case .available = SystemLanguageModel.default.availability else {
            throw TaskAssistantError.modelUnavailable
        }

        let session = LanguageModelSession(
            instructions: "Break the given task into 3 to 6 concrete subtasks, and suggest which teammate should own the first one."
        )
        return session.streamResponse(to: taskDescription, generating: SubtaskBreakdown.self)
    }
}
extension SubtaskAssistant {
    static func breakdown(for taskDescription: String) async throws -> SubtaskBreakdown {
        guard case .available = SystemLanguageModel.default.availability else {
            throw TaskAssistantError.modelUnavailable}
        let session = LanguageModelSession(
            tools: [TeammateWorkloadTool()],
            instructions: "Break the given task into 3 to 6 concrete subtasks, and suggest which teammate should own the first one. Use the teammateWorkload tool to account for who currently has the least on their plate before choosing."
        )
        let response = try await session.respond(to: taskDescription, generating: SubtaskBreakdown.self)
        return response.content
    }
}
