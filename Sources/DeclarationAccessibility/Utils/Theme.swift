/*
* Software Name: accessibility-statement-lib-ios
* SPDX-FileCopyrightText: Copyright (c) 2021-2023 Orange SA
* SPDX-License-Identifier: Apache-2.0
*
* This software is distributed under the Apache License 2.0.
*/

import Foundation
import SwiftUI

public enum Theme: String {
    
    // ==================
    // MARK: Color access
    // ==================
    
    case innovation
    case orange
    case sosh

    public var color: Color {
        switch self {
        case .innovation:
            return Color("Innovation", bundle: Bundle.ease)
        case .orange:
            return Color("Orange", bundle: Bundle.ease)
        case .sosh:
            return Color("Sosh", bundle: Bundle.ease)
        }
    }
    
    public var buttonColor: Color {
        switch self {
        case .innovation:
            return Color("btn_innovation", bundle: Bundle.ease)
        case .orange:
            return Color("btn_orange", bundle: Bundle.ease)
        case .sosh:
            return Color("btn_sosh", bundle: Bundle.ease)
        }
    }
    
    public var foregroundColor: Color {
        switch self {
        case .innovation:
            return Color("fdg_innovation", bundle: Bundle.ease)
        case .orange:
            return Color("fdg_orange", bundle: Bundle.ease)
        case .sosh:
            return Color("fdg_sosh", bundle: Bundle.ease)
        }
    }
}
