
import SwiftUI

struct DetailView: View {
    @Binding var renovationProject: RenovationProject
    @State private var showEditView = false
    @State private var renovationProjectForEditing = RenovationProject()
    
    var body: some View {
        VStack(alignment: .leading) {
            Header(renovationProject: renovationProject)
                
            WorkQuality(renovationProject: renovationProject)
            
            Divider()
            
            PunchList(renovationProject: renovationProject)
            
            Divider()
            
            Budget(renovationProject: renovationProject)
            
            Spacer()
        }
        .padding(.all)
        .navigationTitle(renovationProject.renovationArea)
        .navigationBarItems(trailing: Button(action: {
            renovationProjectForEditing = self.renovationProject
            showEditView = true
        }, label: {
            Text("Edit")
        }))
        .sheet(isPresented: $showEditView, content: {
            NavigationView {
                EditView(renovationProject: $renovationProjectForEditing)
                    .navigationBarItems(
                        
                        leading: Button(action: {
                            showEditView = false
                        }, label: {
                            Text("Cancel")
                        }),
                        
                        trailing: Button(action: {
                            showEditView = false
                            self.renovationProject = renovationProjectForEditing
                        }, label: {
                            Text("Done")
                        }))
            }
        })
    }
}

// MARK: Header section
struct Header: View {
    var renovationProject: RenovationProject
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Image(renovationProject.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 360)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(radius: 5)
                    .overlay(
                        Text(renovationProject.isFlagged ? "FLAGGED FOR REVIEW" : "")
                            .padding(5)
                            .foregroundColor(.white)
                            .background(Color.black.opacity(0.8))
                            .padding()
                        , alignment: .topTrailing
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.white, lineWidth: 5)
                    )
                    .overlay(
                        ProgressInfoCard(renovationProject: renovationProject)
                            .padding(),
                        alignment: .bottom
                    )
                Spacer()
            }
        }
    }
}

// MARK: Progress Info Card
struct ProgressInfoCard: View {
    var renovationProject: RenovationProject
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .foregroundColor(.white)
                .opacity(0.9)
            
            VStack {
                HStack {
                    ProgressView(value: renovationProject.percentComplete)
                    Text(renovationProject.formattedPercentComplete)
                }
                Text("Due on \(renovationProject.formattedDueDate)")
            }.padding()
            
        }.frame(width: 310, height: 100)
    }
}

// MARK: Work Quality section
struct WorkQuality: View {
    var renovationProject: RenovationProject
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Work Quality")
                .font(.headline)
                .foregroundColor(.accentColor)
                .padding(.bottom, 2)
            
            workQualitySymbol
                .foregroundColor(renovationProject.workQuality == .na ? .gray : .yellow)
                .font(.title3)
                .accessibility(hidden: true)
        }
    }
    
    var workQualitySymbol: some View {
        HStack {
            // First Star
            if [.poor, .fair, .good, .excellent].contains(renovationProject.workQuality) {
                Image(systemName: "star.fill")
            } else {
                Image(systemName: "star")
            }
            
            // Second Star
            if [.fair, .good, .excellent].contains(renovationProject.workQuality) {
                Image(systemName: "star.fill")
                    .transition(.opacity)
            } else {
                Image(systemName: "star")
            }
            
            // Third Star
            if [.good, .excellent].contains(renovationProject.workQuality) {
                Image(systemName: "star.fill")
                    .transition(.opacity)
            } else {
                Image(systemName: "star")
            }
            
            // Fourth Star
            if [.excellent].contains(renovationProject.workQuality) {
                Image(systemName: "star.fill")
                    .transition(.opacity)
            } else {
                Image(systemName: "star")
            }
        }
    }
}

// MARK: Punch List section
struct PunchList: View {
    var renovationProject: RenovationProject
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Punch List")
                .font(.headline)
                .foregroundColor(.accentColor)
                .padding(.bottom, 2)
            
            ForEach(renovationProject.punchList, id: \.task) { punchListItem in
                Label(
                    title: { Text(punchListItem.task) },
                    icon: { punchListItem.completionStatusSymbol })
            }
        }
    }
}


// MARK: Budget section
struct Budget: View {
    var renovationProject: RenovationProject
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Budget")
                .font(.headline)
                .foregroundColor(.accentColor)
                .padding(.bottom, 2)
            
            Label(
                title: { Text(renovationProject.budgetStatus.rawValue) },
                icon: { renovationProject.budgetStatusSymbol
                    .foregroundColor(renovationProject.budgetStatusForegroundColor) }
            )
            
            HStack {
                Text("Amount Allocated:")
                Spacer()
                Text(renovationProject.formattedBudgetAmountAllocated)
            }
            
            HStack {
                Text("Spent to-date:")
                Spacer()
                Text(renovationProject.formattedBudgetSpentToDate)
                    .underline()
            }
            
            HStack {
                Text("Amount remaining:")
                    .bold()
                Spacer()
                Text(renovationProject.formattedBudgetAmountRemaining)
                    .bold()
            }
        }
    }
}

// MARK: Previews
struct DetailView_Previews: PreviewProvider {
    struct StatefulPreviewWrapper: View {
        @State private var testProject = RenovationProject.testData[0]
        
        var body: some View {
            DetailView(renovationProject: $testProject)
        }
    }
    
    static var previews: some View {
        Group {
            NavigationView {
                StatefulPreviewWrapper()
                
            }
            
            NavigationView {
                StatefulPreviewWrapper()                    .preferredColorScheme(.dark)
            }
        }
    }
}
