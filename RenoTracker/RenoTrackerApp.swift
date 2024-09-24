
import SwiftUI

@main
struct RenoTrackerApp: App {
    private var renovationProjectDataManager = RenovationProjectDataManager()
    @State private var renovationProjects = [RenovationProject]()
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            RenovationProjectsView(renovationProjects: self.$renovationProjects)
                .onAppear(perform: {
                    renovationProjectDataManager.load { renovationProjects in
                        self.renovationProjects = renovationProjects
                    }
                })
                .onChange(of: scenePhase) { oldPhase, newPhase in
                    if newPhase == .inactive {
                        renovationProjectDataManager.save(renovationProjects: self.renovationProjects)
                    }
                }
        }
    }
}
