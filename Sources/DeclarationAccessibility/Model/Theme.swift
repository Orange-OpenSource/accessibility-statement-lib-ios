//
//  File.swift
//  
//
//  Created by Orange on 24/09/2023.
//

import Foundation
import SwiftUI

enum Theme: String {
    case innovation
    case orange

    var color: Color {
        switch self {
        case .innovation:
            return Color.blue
        case .orange:
            return Color(UIColor(red: 0.883, green: 0.463, blue: 0.176, alpha: 1))
        }
    }
}
