// Software Name: accessibility-statement-lib-ios
// SPDX-FileCopyrightText: Copyright (c) Orange SA
// SPDX-License-Identifier: Apache-2.0
//
// This software is distributed under the Apache 2.0 license,
// the text of which is available at https://opensource.org/license/apache-2-0
// or see the "LICENSE" file for more details.

#if os(iOS)
import SwiftUI
import OUDSSwiftUI
import OUDSTokensRaw

/// A `View` to define a circle which can be empty, a bit empty or not
struct CircularProgressView: View {

    var statement: Statement
    @Environment(\.theme) private var theme

    private let circleSize: CGFloat = 200

    var body: some View {
        VStack {
            ZStack {
                // Background for the progress bar
                Circle()
                    .stroke(lineWidth: BorderRawTokens.width200)
                    .opacity(OpacityRawTokens._320)
                    .oudsForegroundColor(theme.colors.bgSecondary)
                    .frame(width: circleSize, height: circleSize)

                Text(
                    NSLocalizedString(
                        "average_title_label",
                        tableName: nil,
                        bundle: .module,
                        value: "",
                        comment: "")
                        .replacingOccurrences(of: "@", with: statement.conformityAverageDisplay)
                )
                .bodyDefaultLarge(theme)
                .multilineTextAlignment(.center)
                .frame(width: 150, height: 150)
                .accessibilityHidden(true)

                // Foreground for the actual progress bar
                Circle()
                    .trim(from: 0.0, to: min(statement.conformityAverage, 1.0))
                    .stroke(style: StrokeStyle(lineWidth: BorderRawTokens.width200, lineCap: .round, lineJoin: .round))
                    .oudsForegroundColor(theme.colors.contentBrandPrimary)
                    .rotationEffect(Angle(degrees: 270.0))
                    .animation(.linear, value: statement.conformityAverage)
                    .frame(width: circleSize, height: circleSize)
            }

            Text(
                NSLocalizedString(
                    "result_declaration_subtitle",
                    tableName: nil,
                    bundle: .module,
                    value: "",
                    comment: "")
                    .replacingOccurrences(of: "@", with: statement.conformityAverageDisplay)
            )
            .bodyDefaultLarge(theme)
            .multilineTextAlignment(.center)
            .padding(.top, theme.spaces.fixedSmall)
            .padding([.leading, .trailing], theme.spaces.fixedXlarge)

            OUDSDivider(color: .default)
        }
    }
}

// MARK: - Xcode Preview

struct CircularProgressView_Previews: PreviewProvider {
    static var previews: some View {
        OUDSThemeableView(theme: SoshTheme()) {
            CircularProgressView(
                statement: Statement(
                    conformityAverage: 0.75,
                    conformityAverageDisplay: "75"))
                .environment(\.locale, .init(identifier: "fr"))
        }
    }
}

#endif
