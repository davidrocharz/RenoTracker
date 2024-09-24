
import Foundation
import SwiftUI

extension PunchListItem {
    var completionStatusSymbol: Image {
        switch self.status {
        case .complete : return Image(systemName: "checkmark.square")
        case .inProgress : return Image(systemName: "asterisk.circle")
        case .notStarted : return Image(systemName: "square")
        }
    }
}
