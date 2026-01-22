// Software Name: accessibility-statement-lib-ios
// SPDX-FileCopyrightText: Copyright (c) Orange SA
// SPDX-License-Identifier: Apache-2.0
//
// This software is distributed under the Apache 2.0 license,
// the text of which is available at https://opensource.org/license/apache-2-0
// or see the "LICENSE" file for more details.

import Foundation

extension Bundle {

    /// Bundle of the accessibility statement iOS library
    public static var a11yStatementLib: Bundle {
        #if SWIFT_PACKAGE
        return Bundle.module
        #else
        return Bundle(for: A11YStatementLib.self)
        #endif
    }
}

#if SWIFT_PACKAGE
#else
// swiftlint:disable required_deinit
private final class A11YStatementLibBundleResource {}
// swiftlint:enable required_deinit
#endif
