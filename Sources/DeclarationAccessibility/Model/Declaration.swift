/*
* Software Name: accessibility-statement-lib-ios
* SPDX-FileCopyrightText: Copyright (c) 2021-2023 Orange SA
* SPDX-License-Identifier: Apache-2.0
*
* This software is distributed under the Apache License 2.0.
*/

import Foundation

struct Declaration {
    
    // ================
    // MARK: Type Alias
    // ======================
    
    typealias AuditDate = (toDisplay: String, toVocalize: String)
    
    // =======================
    // MARK: Stored Properties
    // =======================
    
    public var title : String = String()
    public var lang: String = String()
    public var status: String = String()
    public var auditDate: AuditDate? = nil
    public var conformity: String = String()
    public var conformityAverage: CGFloat = CGFloat()
    public var conformityAverageDisplay: String = String ()
    public var referentialName: String = String()
    public var referentialVersion: String = String()
    public var referentialLevel: String = String()
    public var technologies: String = String()
    public var detailUrl: String = String()
    public var identityAdresse: String = String()
    public var identityName: String = String()
    public var useWebView: Bool = Bool()
}
