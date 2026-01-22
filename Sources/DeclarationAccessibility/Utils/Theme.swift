// Software Name: accessibility-statement-lib-ios
// SPDX-FileCopyrightText: Copyright (c) Orange SA
// SPDX-License-Identifier: Apache-2.0
//
// This software is distributed under the Apache 2.0 license,
// the text of which is available at https://opensource.org/license/apache-2-0
// or see the "LICENSE" file for more details.

import Foundation
import SwiftUI

/// A theme to apply to accessibility statement
public enum Theme: String {

    /// For the Orange Innovation Cup
    case innovation

    /// For the Orange brand products
    case orange

    /// For the Sosh brand products
    case sosh

    public var color: Color {
        switch self {
        case .innovation:
            return Color("Innovation", bundle: Bundle.a11yStatementLib)
        case .orange:
            return Color("Orange", bundle: Bundle.a11yStatementLib)
        case .sosh:
            return Color("Sosh", bundle: Bundle.a11yStatementLib)
        }
    }

    public var buttonColor: Color {
        switch self {
        case .innovation:
            return Color("btn_innovation", bundle: Bundle.a11yStatementLib)
        case .orange:
            return Color("btn_orange", bundle: Bundle.a11yStatementLib)
        case .sosh:
            return Color("btn_sosh", bundle: Bundle.a11yStatementLib)
        }
    }

    public var foregroundColor: Color {
        switch self {
        case .innovation:
            return Color("fdg_innovation", bundle: Bundle.a11yStatementLib)
        case .orange:
            return Color("fdg_orange", bundle: Bundle.a11yStatementLib)
        case .sosh:
            return Color("fdg_sosh", bundle: Bundle.a11yStatementLib)
        }
    }
}
