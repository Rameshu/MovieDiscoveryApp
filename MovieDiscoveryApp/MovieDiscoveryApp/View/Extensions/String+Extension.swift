//
//  String+Extension.swift
//  MovieDiscoveryApp
//
//  Created by RAMESHUZ on 02/04/25.
//

import Foundation

extension String {
    func toYear() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        guard let date = dateFormatter.date(from: self) else { return nil }

        let yearFormatter = DateFormatter()
        yearFormatter.dateFormat = "yyyy"
        return yearFormatter.string(from: date)
    }
}
