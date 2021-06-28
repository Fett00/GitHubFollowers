//
//  DateExt.swift
//  GitHubFollowers
//
//  Created by Садык Мусаев on 18.06.2021.
//

import Foundation

extension Date{

    static func gHStringToDateString(ghString:String) -> String{
        
        let isoDateFormatter = ISO8601DateFormatter()
        let isoDate = isoDateFormatter.date(from: ghString)
        let options:ISO8601DateFormatter.Options = [.withYear, .withMonth, .withDay, .withDashSeparatorInDate]
        
        if let wrapedDate = isoDate{
            
            return ISO8601DateFormatter.string(from: wrapedDate, timeZone: .current, formatOptions: options)
        }
        else{
            return ""
        }
    }
}
