import AppIntents

extension TaskItem: AppEntity {
    static let typeDisplayRepresentation: TypeDisplayRepresentation = "Task"
    static let defaultQuery = TaskEntityQuery()

    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(title: "\(title)", subtitle: "\(assignee?.name ?? "Unassigned")")
    }
}

struct TaskEntityQuery: EntityQuery {
    func entities(for identifiers: [TaskItem.ID]) async throws -> [TaskItem] {
        TasksStore.shared.tasks.filter { identifiers.contains($0.id) }
    }

    func suggestedEntities() async throws -> [TaskItem] {
        TasksStore.shared.tasks
    }
}

extension TaskEntityQuery: EntityStringQuery {
    func entities(matching string: String) async throws -> [TaskItem] {
        TasksStore.shared.tasks.filter { $0.title.localizedCaseInsensitiveContains(string) }
    }
}

extension TaskItem.Priority: AppEnum {
    static let typeDisplayRepresentation: TypeDisplayRepresentation = "Priority"
    static let caseDisplayRepresentations: [TaskItem.Priority: DisplayRepresentation] = [
        .low: DisplayRepresentation(title: "Low", image: .init(systemName: "arrow.down.circle.fill")),
        .medium: DisplayRepresentation(title: "Medium", image: .init(systemName: "equal.circle.fill")),
        .high: DisplayRepresentation(title: "High", image: .init(systemName: "exclamationmark.circle.fill"))
    ]
}

extension Teammate: AppEntity {
    static let typeDisplayRepresentation: TypeDisplayRepresentation = "Teammate"
    static let defaultQuery = TeammateEntityQuery()

    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(title: "\(name)")
    }
}

struct TeammateEntityQuery: EntityQuery {
    func entities(for identifiers: [Teammate.ID]) async throws -> [Teammate] {
        TasksStore.shared.teammates.filter { identifiers.contains($0.id) }
    }

    func suggestedEntities() async throws -> [Teammate] {
        TasksStore.shared.teammates
    }
}
