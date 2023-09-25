//
//  File.swift
//  
//
//  Created by Orange on 24/09/2023.
//

import Foundation
import SwiftUI

public enum Theme: String {
    case innovation
    case orange

    public var color: Color {
        switch self {
        case .innovation:
            return Color(UIColor(red: 0.138, green: 0.352, blue: 0.726, alpha: 1))
        case .orange:
            return Color(UIColor(red: 0.841, green: 0.490, blue: 0.254, alpha: 1))
        }
    }
}
