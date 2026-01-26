// Software Name: accessibility-statement-lib-ios
// SPDX-FileCopyrightText: Copyright (c) Orange SA
// SPDX-License-Identifier: Apache-2.0
//
// This software is distributed under the Apache 2.0 license,
// the text of which is available at https://opensource.org/license/apache-2-0
// or see the "LICENSE" file for more details.

@testable import DeclarationAccessibility
import Testing

struct StatementTests {

    @Test("By default a StatementDataParser has default Statement")
    func statementDataParserDefaultHasDefaultStatement() {

        // Given
        let statementDataParser = StatementDataParser()

        // When
        let statement = statementDataParser.statement

        // Then
        #expect(statement.title.isEmpty)
        #expect(statement.lang.isEmpty)
        #expect(statement.status.isEmpty)
        #expect(statement.auditDate == nil)
        #expect(statement.conformityAverage == 0.0)
        #expect(statement.conformityAverageDisplay.isEmpty)
        #expect(statement.referentialName.isEmpty)
        #expect(statement.referentialVersion.isEmpty)
        #expect(statement.referentialLevel.isEmpty)
        #expect(statement.technologies.isEmpty)
        #expect(statement.detailUrl.isEmpty)
        #expect(statement.identityAddress.isEmpty)
        #expect(statement.identityName.isEmpty)
        #expect(!statement.mustUseWebView)
    }

    @Test("By default a StatementDataParser does not have found total result")
    func statementDataParserDefaulDoesNotHaveFoundResult() {

        // Given
        let statementDataParser = StatementDataParser()

        // When
        let foundTotalResult = statementDataParser.foundTotalResult

        // Then
        #expect(!foundTotalResult)
    }
}
