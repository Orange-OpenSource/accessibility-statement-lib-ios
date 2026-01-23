// Software Name: accessibility-statement-lib-ios
// SPDX-FileCopyrightText: Copyright (c) Orange SA
// SPDX-License-Identifier: Apache-2.0
//
// This software is distributed under the Apache 2.0 license,
// the text of which is available at https://opensource.org/license/apache-2-0
// or see the "LICENSE" file for more details.

import Foundation
import OUDSSwiftUI
import SwiftUI

/// A theme to apply to accessibility statement
///
/// - Since: 1.0.0
public enum Theme: String {

    /// For the Orange Innovation Cup
    @available(*, deprecated, message: "Use wireframe theme instead")
    case innovation

    /// For the Orange brand products
    case orange

    /// For the Orange brand products with contraintes of spaces and sizes
    case orangeBusinessTools

    /// For the Sosh brand products
    case sosh

    /// For wireframe / prototyping
    case wireframe
}
