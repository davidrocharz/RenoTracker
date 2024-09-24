
import SwiftUI

struct EditView: View {
    @Binding var renovationProject: RenovationProject
    
    var body: some View {
        Form {
            Section(header: Text("Project Info")) {
                TextField("Renovation area", text: $renovationProject.renovationArea)
                    .disableAutocorrection(true)
                
                DatePicker(selection: $renovationProject.dueDate, displayedComponents: .date) {
                    Text("Due Date")
                }
                .datePickerStyle(CompactDatePickerStyle())
                
                Picker(selection: $renovationProject.workQuality, label: Text("Work Quality Rating")) {
                    
                    ForEach(RenovationProject.WorkQualityRating.allCases.reversed(), id: \.self) { workQualityRating in
                        Text(workQualityRating.rawValue).tag(workQualityRating)
                    }
                }
                .pickerStyle(DefaultPickerStyle())
                
                Toggle(isOn: $renovationProject.isFlagged, label: {
                    Text("Flagged for review")
                })
            }
            
            Section(header: Text("Punch List")) {
                ForEach(renovationProject.punchList, id: \.task) { punchListItem in
                    let punchListItemIndex = renovationProject.punchList.firstIndex(where: {$0.task == punchListItem.task })!
                    
                    let punchListItemBinding = $renovationProject.punchList[punchListItemIndex]
                    
                    Picker(punchListItem.task, selection: punchListItemBinding.status) {
                        Text("Not Started").tag(PunchListItem.CompletionStatus.notStarted)
                        Text("In Progress").tag(PunchListItem.CompletionStatus.inProgress)
                        Text("Complete").tag(PunchListItem.CompletionStatus.complete)
                    }
                    .pickerStyle(DefaultPickerStyle())
                }
            }
            
            Section(header: Text("Budget")) {
                HStack{
                    Text("Spent To-Date")
                    Spacer()
                    TextField("Spent To-Date", value: $renovationProject.budgetSpentToDate, formatter: NumberFormatter())
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.numberPad)
                }
            }
        }
    }
}

struct EditView_Previews: PreviewProvider {
    struct StatefulPreviewWrapper: View {
        @State private var testProject = RenovationProject.testData[0]
        
        var body: some View {
            NavigationView {
                EditView(renovationProject: $testProject)
            }
        }
    }
    
    static var previews: some View {
        StatefulPreviewWrapper()
    }
}
