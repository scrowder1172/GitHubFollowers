//
//  Dates+Ext.swift
//  GitHubFollowers.Storyboard
//
//  Created by SCOTT CROWDER on 5/7/24.
//

import Foundation

extension Date {
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        
        return dateFormatter.string(from: self)
    }
}
