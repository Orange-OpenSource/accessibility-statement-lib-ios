/*
* Software Name: accessibility-statement-lib-ios
* SPDX-FileCopyrightText: Copyright (c) 2021-2023 Orange SA
* SPDX-License-Identifier: Apache-2.0
*
* This software is distributed under the Apache License 2.0.
*/

import Foundation
import os

struct Log {

    private init() {}

    private static let logger = Logger()
    private static let prefix: String = "[Accessibility Statement Library]"

    static func debug(_ message: String) {
        #if DEBUG
        logger.debug("\(prefix) Debug: \(message)")
        #endif
    }

    static func log(_ message: String) {
        #if DEBUG
        logger.log("\(prefix) \(message)")
        #endif
    }

    static func info(_ message: String) {
        logger.info("\(prefix) Info: \(message)")
    }

    static func warning(_ message: String) {
        logger.warning("\(prefix) Warning: \(message)")
    }

    static func error(_ message: String) {
        logger.error("\(prefix) Error: \(message)")
    }
}
