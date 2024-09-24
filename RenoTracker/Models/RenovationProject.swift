import Foundation

struct RenovationProject: Codable {
    var projectNumber: Int = 0
    var renovationArea: String = ""
    var imageName: String = ""
    var dueDate: Date = Date.distantFuture
    var lastProgressUpdate: Date? = nil
    var workQuality: WorkQualityRating = .na
    var isFlagged: Bool = false
    var punchList: [PunchListItem] = []
    var budgetAmountAllocated: Double = 0.0
    var budgetSpentToDate: Double = 0.0
    var inspectionLog: [InspectionLogEntry] = []
    
    enum WorkQualityRating: String, Codable, CaseIterable {
        case na = "N/A"
        case poor = "Poor"
        case fair = "Fair"
        case good = "Good"
        case excellent = "Excellent"
        
        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            let status = try? container.decode(String.self)
            
            switch status {
            case "N/A": self = .na
            case "Poor": self = .poor
            case "Fair": self = .fair
            case "Good": self = .good
            case "Excellent": self = .excellent
            default: self = .na
            }
        }
    }
}

struct PunchListItem: Codable {
    var task: String = ""
    var status: CompletionStatus = .notStarted
    
    enum CompletionStatus: String, Codable {
        case notStarted = "Not Started"
        case inProgress = "In Progress"
        case complete = "Complete"
        
        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            let status = try? container.decode(String.self)
            
            switch status {
            case "Not Started": self = .notStarted
            case "In Progress": self = .inProgress
            case "Complete": self = .complete
            default: self = .notStarted
            }
        }
    }
}

struct InspectionLogEntry: Codable {
    var entryDate: Date
    var details: String
}

enum BudgetStatus: String {
    case onBudget = "On Budget"
    case overBudget = "Over Budget"
}

extension RenovationProject {
    static var testData: [RenovationProject]
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return [
            RenovationProject(projectNumber: 2021001,
                              renovationArea: "Front Lobby",
                              imageName: "front-lobby",
                              dueDate: dateFormatter.date(from: "2021-08-01")!,
                              lastProgressUpdate: dateFormatter.date(from: "2021-05-28")!,
                              workQuality: .good,
                              isFlagged: false,
                              punchList: [
                                PunchListItem(task: "Remodel front desk", status: .complete),
                                PunchListItem(task: "Retile entry", status: .complete),
                                PunchListItem(task: "Replace light fixtures", status: .complete),
                                PunchListItem(task: "Paint walls", status: .inProgress),
                                PunchListItem(task: "Hang new artwork", status: .notStarted)
                              ],
                              budgetAmountAllocated: 15000,
                              budgetSpentToDate: 18350.0,
                              inspectionLog: [
                                InspectionLogEntry(entryDate: Date().advanced(by: -1), details: "Test entry 1"), InspectionLogEntry(entryDate: Date(), details: "Test entry 2")])
            ,
            RenovationProject(projectNumber: 2021002,
                              renovationArea: "Main Entrance",
                              imageName: "main-entrance",
                              dueDate: dateFormatter.date(from: "2021-05-30")!,
                              lastProgressUpdate: nil,
                              workQuality: .fair,
                              isFlagged: true,
                              punchList: [
                                PunchListItem(task: "Replace front door", status: .notStarted),
                                PunchListItem(task: "Install security cameras", status: .notStarted)
                              ],
                              budgetAmountAllocated: 10000,
                              budgetSpentToDate: 0.0,
                              inspectionLog: [InspectionLogEntry(entryDate: Date(), details: "Test entry")])
        ]
    }
}
