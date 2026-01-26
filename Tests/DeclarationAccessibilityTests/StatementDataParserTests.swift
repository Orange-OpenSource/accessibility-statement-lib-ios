// Software Name: accessibility-statement-lib-ios
// SPDX-FileCopyrightText: Copyright (c) Orange SA
// SPDX-License-Identifier: Apache-2.0
//
// This software is distributed under the Apache 2.0 license,
// the text of which is available at https://opensource.org/license/apache-2-0
// or see the "LICENSE" file for more details.

@testable import DeclarationAccessibility
import Testing

struct StatementDataParserTests {

    @Test("By default a StatementDataParser has empty title")
    func statementDefaultHasEmptyTitle() {
        let statement = Statement()
        #expect(statement.title.isEmpty)
    }

    @Test("By default a Statement has empty lang")
    func statementDefaultHasEmptyLang() {
        let statement = Statement()
        #expect(statement.lang.isEmpty)
    }

    @Test("By default a Statement has empty sttus")
    func statementDefaultHasEmptyStatus() {
        let statement = Statement()
        #expect(statement.status.isEmpty)
    }

    @Test("By default a Statement does not have audit date")
    func statementDefaultHasNilAuditDate() {
        let statement = Statement()
        #expect(statement.auditDate == nil)
    }

    @Test("By default a Statement has empty audit conformity")
    func statementDefaultHasEmptyConformity() {
        let statement = Statement()
        #expect(statement.conformity.isEmpty)
    }

    @Test("By default a Statement has conformity average of 0.0")
    func statementDefaultHasConformityAverageOfZero() {
        let statement = Statement()
        #expect(statement.conformityAverage == 0.0)
    }

    @Test("By default a Statement has empty conformity average display")
    func statementDefaultHasEmptyConformityAverageDisplay() {
        let statement = Statement()
        #expect(statement.conformityAverageDisplay.isEmpty)
    }

    @Test("By default a Statement has empty referential name")
    func statementDefaultHasEmptyReferentialName() {
        let statement = Statement()
        #expect(statement.referentialName.isEmpty)
    }

    @Test("By default a Statement has empty referential version")
    func statementDefaultHasEmptyReferentialVersion() {
        let statement = Statement()
        #expect(statement.referentialVersion.isEmpty)
    }

    @Test("By default a Statement has empty referential elvel")
    func statementDefaultHasEmptyReferentiallLvel() {
        let statement = Statement()
        #expect(statement.referentialLevel.isEmpty)
    }

    @Test("By default a Statement has empty technologies")
    func statementDefaultHasEmptyTechnologies() {
        let statement = Statement()
        #expect(statement.technologies.isEmpty)
    }

    @Test("By default a Statement has empty detail URL")
    func statementDefaultHasEmptyDetailURL() {
        let statement = Statement()
        #expect(statement.detailUrl.isEmpty)
    }

    @Test("By default a Statement has empty identity address")
    func statementDefaultHasEmptyIdentityAddress() {
        let statement = Statement()
        #expect(statement.identityAddress.isEmpty)
    }

    @Test("By default a Statement has empty identity name")
    func statementDefaultHasEmptyIdentityName() {
        let statement = Statement()
        #expect(statement.identityName.isEmpty)
    }

    @Test("By default a Statement must not display web view")
    func statementDefaultMustNotDisplayWebView() {
        let statement = Statement()
        #expect(!statement.mustUseWebView)
    }
}
