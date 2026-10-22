//
//  Copyright © 2024 Konrad Group. All rights reserved.
//

import Foundation

extension Date {
    var dateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        return formatter.string(from: self)
    }
}
