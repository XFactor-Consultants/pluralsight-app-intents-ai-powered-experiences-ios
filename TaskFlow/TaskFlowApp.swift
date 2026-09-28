import SwiftUI
@main

struct TaskFlowApp: App {
    
    @State private var tasksStore = TasksStore()
    
    @State private var contentCache: LocalContentCache
    @State private var authStore: AuthStore
    
    init() {
        
        let cache = LocalContentCache()
        
        _contentCache = State(initialValue: cache)
        
        _authStore = State(initialValue: AuthStore(contentCache: cache))
        
    }
    
    var body: some Scene {
        
        WindowGroup {
            
            RootView()
            
                .environment(tasksStore)
            
                .environment(authStore)
            
                .environment(contentCache)
            
        }
    }
}
