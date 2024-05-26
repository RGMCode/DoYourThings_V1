//
//  DoYourThings.swift
//  DoYourThings
//
//  Created by RGMCode on 26.05.24.
//

import SwiftUI

struct DoYourThings: Identifiable, Hashable, Codable {
    var id = UUID()
    var dytTopic: String
    var dytDetails: String
    var dytColor: String
}
