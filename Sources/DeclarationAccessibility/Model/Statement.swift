// Software Name: accessibility-statement-lib-ios
// SPDX-FileCopyrightText: Copyright (c) Orange SA
// SPDX-License-Identifier: Apache-2.0
//
// This software is distributed under the Apache 2.0 license,
// the text of which is available at https://opensource.org/license/apache-2-0
// or see the "LICENSE" file for more details.

import Foundation

/// Defines what an accessibility statement must be.
struct Statement {
    var title: String
    var lang: String
    var status: String
    var auditDate: String
    var conformity: String
    var conformityAverage: CGFloat
    var conformityAverageDisplay: String
    var referentialName: String
    var referentialVersion: String
    var referentialLevel: String
    var technologies: String
    var detailUrl: String
    var identityAddress: String
    var identityName: String
    var mustUseWebView: Bool

    init(
        title: String = "",
        lang: String = "",
        status: String = "",
        auditDate: String = "",
        conformity: String = "",
        conformityAverage: CGFloat = 0.0,
        conformityAverageDisplay: String = "",
        referentialName: String = "",
        referentialVersion: String = "",
        referentialLevel: String = "",
        technologies: String = "",
        detailUrl: String = "",
        identityAddress: String = "",
        identityName: String = "",
        mustUseWebView: Bool = false)
    {
        self.title = title
        self.lang = lang
        self.status = status
        self.auditDate = auditDate
        self.conformity = conformity
        self.conformityAverage = conformityAverage
        self.conformityAverageDisplay = conformityAverageDisplay
        self.referentialName = referentialName
        self.referentialVersion = referentialVersion
        self.referentialLevel = referentialLevel
        self.technologies = technologies
        self.detailUrl = detailUrl
        self.identityAddress = identityAddress
        self.identityName = identityName
        self.mustUseWebView = mustUseWebView
    }
}
