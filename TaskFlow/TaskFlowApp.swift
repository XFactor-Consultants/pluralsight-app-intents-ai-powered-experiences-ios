import SwiftUI

@main
struct TaskFlowApp: App {

    @State private var tasksStore = TasksStore.shared

    var body: some Scene {

        WindowGroup {

            RootView()
                .environment(tasksStore)

        }
    }
}
