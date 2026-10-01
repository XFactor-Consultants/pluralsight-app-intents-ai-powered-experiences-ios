import AppIntents
struct AssigneeNotFoundError: Error {}

struct CreateTaskIntent: AppIntent, ForegroundContinuableIntent {
    
    static var title: LocalizedStringResource = "Create Task"
    
    static var description = IntentDescription("Creates a new task in TaskFlow and assigns it to a teammate.")
    
    @Parameter(title: "Task Title")
    var taskTitle: String
    @Parameter(title: "Assignee Name")
    var assigneeName: String
    
    static var parameterSummary: some ParameterSummary {
        Summary("Create \(\.$taskTitle) for \(\.$assigneeName)")
    }
    
    func perform() async throws -> some IntentResult & ProvidesDialog {
        
        let store = TasksStore.shared
        guard let matchedAssignee = store.teammates.first(where: { $0.name.caseInsensitiveCompare(assigneeName) == .orderedSame }) else {
            try await requestToContinueInForeground()
            throw AssigneeNotFoundError()
        }
        
        let newTask = TaskItem(title: taskTitle, assignee: matchedAssignee)
        
        store.addTask(newTask)
        
        return .result(dialog: "Created \(taskTitle) for \(matchedAssignee.name).")
    }
}
