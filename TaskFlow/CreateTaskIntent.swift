import AppIntents
struct CreateTaskIntent: AppIntent {
    
    static var title: LocalizedStringResource = "Create Task"
    
    static var description = IntentDescription("Creates a new task in TaskFlow and assigns it to a teammate.")
    
    @Parameter(title: "Task Title")
    var taskTitle: String
    @Parameter(title: "Assignee")
    var assignee: Teammate
    static var parameterSummary: some ParameterSummary {
        Summary("Create \(\.$taskTitle) for \(\.$assignee)")
    }
    
    func perform() async throws -> some IntentResult & ReturnsValue<TaskItem> & ProvidesDialog {
        let store = TasksStore.shared
        let newTask = TaskItem(title: taskTitle, assignee: assignee)
        store.addTask(newTask)
        return .result(value: newTask, dialog: "Created \(taskTitle) for \(assignee.name).")
    }
}
