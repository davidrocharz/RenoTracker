
import SwiftUI

struct RenovationProjectsView: View {
    @Binding var renovationProjects: [RenovationProject]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(renovationProjects) { renovationProject in
                    let projectIndex = renovationProjects.firstIndex(where: { $0.id == renovationProject.id })!
                    
                    let renovationProjectBinding = $renovationProjects[projectIndex]
                    
                    NavigationLink(destination: DetailView(renovationProject: renovationProjectBinding)) {
                        RenovationProjectRow(renovationProject: renovationProject)
                    }
                }
            }
            .navigationTitle("Home")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    struct StatefulPreviewWrapper: View {
        @State private var testProjects = RenovationProject.testData
        
        var body: some View {
            RenovationProjectsView(renovationProjects: $testProjects)
        }
    }
    
    static var previews: some View {
        StatefulPreviewWrapper()
    }
}
