
import SwiftUI

struct RenovationProjectRow: View {
    var renovationProject: RenovationProject
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Image(renovationProject.imageName)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .aspectRatio(contentMode: .fill)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                VStack(alignment: .leading) {
                    Text(renovationProject.renovationArea)
                        .font(.headline)
                    VStack(alignment: .leading) {
                        Label("Due on \(renovationProject.formattedDueDate)", systemImage: "calendar")
                            .foregroundColor(renovationProject.dueDate < Date() ? .red : .accentColor)
                        Label("\(renovationProject.totalPunchListItems) items", systemImage: "wrench.and.screwdriver.fill")
                        Label("\(renovationProject.formattedPercentComplete) complete", systemImage: "percent")
                        Label("\(renovationProject.budgetAmountRemaining < 0 ? "Over budget" : "On budget")", systemImage: "dollarsign.circle")
                            .foregroundColor(renovationProject.budgetAmountRemaining < 0 ? .red : .accentColor)
                    }
                    .font(.callout)
                    .foregroundColor(.accentColor)
                }
                
                Spacer()
            }
        }.padding(.trailing)
    }
}


struct RenovationProjectRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RenovationProjectRow(renovationProject: RenovationProject.testData[0])
                .previewLayout(.fixed(width: 400, height: 100))
            RenovationProjectRow(renovationProject: RenovationProject.testData[0])
                .preferredColorScheme(.dark)
                .previewLayout(.fixed(width: 400, height: 100))
        }
    }
}
