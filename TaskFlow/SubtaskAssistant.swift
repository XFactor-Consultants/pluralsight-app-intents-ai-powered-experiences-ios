//
//  SubtaskAssistant.swift
//  TaskFlow
//
import FoundationModels

enum SubtaskAssistant {
    static func streamBreakdown(for taskDescription: String) -> LanguageModelSession.ResponseStream<SubtaskBreakdown> {
        let session = LanguageModelSession(
            tools: [TeammateWorkloadTool()],
            instructions: "Break the given task into 3 to 6 concrete subtasks, and suggest which teammate should own the first one. Use the teammateWorkload tool to account for who currently has the least on their plate before choosing."
        )
        return session.streamResponse(to: taskDescription, generating: SubtaskBreakdown.self)
    }

    static func streamBreakdownWithoutTool(for taskDescription: String) -> LanguageModelSession.ResponseStream<SubtaskBreakdown> {
        let session = LanguageModelSession(
            instructions: "Break the given task into 3 to 6 concrete subtasks, and suggest which teammate should own the first one."
        )
        return session.streamResponse(to: taskDescription, generating: SubtaskBreakdown.self)
    }
}

