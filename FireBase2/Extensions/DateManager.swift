//
//  DateFormatter.swift
//  FireBase2
//
//  Created by Кирилл Крамар on 26.09.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import Foundation

class DateManager {
    
    static let shared = DateManager()
    private init() {}
    
    func localizeDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: date)
    }
}
