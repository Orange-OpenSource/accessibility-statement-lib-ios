// Software Name: accessibility-statement-lib-ios
// SPDX-FileCopyrightText: Copyright (c) Orange SA
// SPDX-License-Identifier: Apache-2.0
//
// This software is distributed under the Apache 2.0 license,
// the text of which is available at https://opensource.org/license/apache-2-0
// or see the "LICENSE" file for more details.

@testable import DeclarationAccessibility
import Testing

struct ConstantTests {

    @Test("Orange company identity must be Orange SA")
    func orangeCompnayIdentity() {
        #expect(Constants.Orange.identityName == "Orange SA")
    }

    @Test("Orange company address must be the one at Issy-les-Moulineaux")
    func orangeCompany() {
        #expect(Constants.Orange.identityAddress == "Siège social : 111, quai du Président Roosevelt, CS 70222, 91130 Issy-les-Moulineaux CEDEX")
    }
}
