//
//  RestroomDoc.swift
//  Restroom Review
//

import Foundation
import CoreLocation
import FirebaseFirestore

struct hours: Codable {
    var day: String
    var open: Date
    var close: Date
    
    init(day: String, open: Date, close: Date) {
        self.day = day
        self.open = open
        self.close = close
    }
}

public struct Restroom: Codable {
    let name: String
    let location: GeoPoint?
    let created = FieldValue.serverTimestamp()
    let phone: String?
    let hours: Array<hours>?

    enum CodingKeys: String, CodingKey {
        case name
        case phone
        case location
        case hours
    }
}