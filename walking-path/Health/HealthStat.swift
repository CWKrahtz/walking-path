//
//  HealthStat.swift
//  walking-path
//
//  Created by student on 2024/08/11.
//

import Foundation
import SwiftUI

struct Health: Identifiable {
    let id = UUID()
    let title: String //What is the health
    let amount: Double
    let image: String
    let color: Color
}
