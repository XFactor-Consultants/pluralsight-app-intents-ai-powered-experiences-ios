import SwiftUI

/// The canonical (pre-auth) build opens straight into the tab bar.
/// Module 1, Clip 2 replaces this body with a switch over AuthStore.state,
/// so the app asks "signed in or not?" before showing anything.
struct RootView: View {
    
    @Environment(AuthStore.self) private var authStore
    
    var body: some View {
        
        switch authStore.state {
            
        case .signedOut:
            
            SignInView()
            
        case .signedIn:
            
            TabView {
                
                Tab("Tasks", systemImage: "checklist") { TaskListView() }
                
                Tab("Settings", systemImage: "gear") { SettingsView() }
                
            }
            
        }
        
    }
    
}

#Preview {
    RootView()
        .environment(TasksStore())
}
