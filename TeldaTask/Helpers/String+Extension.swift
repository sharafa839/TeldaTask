//
//  Date+Extension.swift
//  TeldaTask
//
//  Created by Sharaf on 12/5/24.
//

import Foundation

extension String {
    func convertFormat(to: String = "EEE MMM yyyy")-> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: self) else { return "N/A"}
        let newFormat = DateFormatter()
        newFormat.dateFormat = to
       let dateInString = newFormat.string(from: date)
        return dateInString
    }
}
