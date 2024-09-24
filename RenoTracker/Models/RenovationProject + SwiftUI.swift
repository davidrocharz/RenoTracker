
import Foundation
import SwiftUI

extension RenovationProject: Identifiable {
    var id: Int {
        self.projectNumber
    }
}

extension RenovationProject {
    var formattedDueDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        return formatter.string(from: dueDate)
    }
    
    var totalPunchListItems: Int {
        punchList.count
    }
    
    var percentComplete: Double {
        let completePunchListItems = punchList.filter { punchListItem in
            punchListItem.status == .complete
        }
        
        let percentComplete = Double(completePunchListItems.count) / Double(totalPunchListItems)
        
        return percentComplete
    }
    
    var formattedPercentComplete: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        
        return formatter.string(from: NSNumber(value: percentComplete)) ?? "0 %"
    }
    
    var budgetAmountRemaining: Double {
        budgetAmountAllocated - budgetSpentToDate
    }
    
    var budgetStatus: BudgetStatus {
        budgetAmountRemaining >= 0 ? .onBudget : .overBudget
    }
    
    var formattedBudgetAmountAllocated: String {
        self.currencyFormatter.string(from: NSNumber(value: budgetAmountAllocated)) ?? "unknown"
    }
    
    var formattedBudgetSpentToDate: String {
        self.currencyFormatter.string(from: NSNumber(value: budgetSpentToDate)) ?? "unknown"
    }
    
    var formattedBudgetAmountRemaining: String {
        self.currencyFormatter.string(from: NSNumber(value: budgetAmountRemaining)) ?? "unknown"
    }
    
    var budgetStatusSymbol: Image {
        budgetStatus == .onBudget ? Image(systemName: "checkmark.circle.fill") : Image(systemName: "x.circle.fill")
    }
    
    var budgetStatusForegroundColor: Color {
        budgetStatus == .onBudget ? .green : .red
    }
    
    private var currencyFormatter: NumberFormatter {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = .currency
        
        return currencyFormatter
    }
}
