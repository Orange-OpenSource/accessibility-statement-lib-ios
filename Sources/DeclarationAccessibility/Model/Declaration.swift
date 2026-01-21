// Software Name: accessibility-statement-lib-ios
// SPDX-FileCopyrightText: Copyright (c) Orange SA
// SPDX-License-Identifier: Apache-2.0
//
// This software is distributed under the Apache 2.0 license,
// the text of which is available at https://opensource.org/license/apache-2-0
// or see the "LICENSE" file for more details.

import Foundation

struct Declaration {
    var title: String = .init()
    var lang: String = .init()
    var status: String = .init()
    var auditDate: String = .init()
    var conformity: String = .init()
    var conformityAverage: CGFloat = .init()
    var conformityAverageDisplay: String = .init()
    var referentialName: String = .init()
    var referentialVersion: String = .init()
    var referentialLevel: String = .init()
    var technologies: String = .init()
    var detailUrl: String = .init()
    var identityAdresse: String = .init()
    var identityName: String = .init()
    var useWebView: Bool = .init()
}
