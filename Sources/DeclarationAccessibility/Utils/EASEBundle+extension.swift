/*
* Software Name: accessibility-statement-lib-ios
* SPDX-FileCopyrightText: Copyright (c) 2021-2023 Orange SA
* SPDX-License-Identifier: Apache-2.0
*
* This software is distributed under the Apache License 2.0.
*/

import Foundation

extension Bundle {
    public static var ease: Bundle {
        #if SWIFT_PACKAGE
        return Bundle.module
        #else
        return Bundle(for: EASEBundleResource.self)
        #endif
    }
}

#if SWIFT_PACKAGE
#else
class EASEBundleResource {}
#endif
