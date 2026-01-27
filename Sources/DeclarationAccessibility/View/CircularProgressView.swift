// Software Name: accessibility-statement-lib-ios
// SPDX-FileCopyrightText: Copyright (c) Orange SA
// SPDX-License-Identifier: Apache-2.0
//
// This software is distributed under the Apache 2.0 license,
// the text of which is available at https://opensource.org/license/apache-2-0
// or see the "LICENSE" file for more details.

#if os(iOS)
import OUDSSwiftUI
import SwiftUI

/// A `View` to define a circle which can be empty, a bit empty or not
struct CircularProgressView: View {

    var statement: Statement
    var theme: OUDSTheme

    private static let circleSize: CGFloat = 200
    private static let titleFrameDimension: CGFloat = 150
    private static let rotationEffect: CGFloat = 270.0

    var body: some View {
        VStack {
            ZStack {
                // Background for the progress bar, full circle
                Circle()
                    .stroke(lineWidth: BorderRawTokens.width200)
                    .opacity(OpacityRawTokens._320)
                    .oudsForegroundColor(theme.colors.contentDisabled)
                    .frame(width: Self.circleSize, height: Self.circleSize)

                Text(
                    NSLocalizedString( // FIXME: Change API
                        "average_title_label",
                        tableName: nil,
                        bundle: .module,
                        value: "",
                        comment: "")
                        .replacingOccurrences(of: "@", with: statement.conformityAverageDisplay)
                )
                .bodyDefaultLarge(theme)
                .multilineTextAlignment(.center)
                .frame(width: Self.titleFrameDimension, height: Self.titleFrameDimension)
                .accessibilityHidden(true)

                // Foreground for the progress bar, maybe partial circle
                Circle()
                    .trim(from: 0.0, to: min(statement.conformityAverage, 1.0))
                    .stroke(style: StrokeStyle(lineWidth: BorderRawTokens.width200, lineCap: .round, lineJoin: .round))
                    .oudsForegroundColor(theme.colors.contentBrandPrimary)
                    .rotationEffect(Angle(degrees: Self.rotationEffect))
                    .animation(.linear, value: statement.conformityAverage)
                    .frame(width: Self.circleSize, height: Self.circleSize)
            }

            Text(
                NSLocalizedString( // FIXME: Change API
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

            OUDSHorizontalDivider(color: .default)
        }
    }
}

// MARK: - Xcode Preview

struct CircularProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressView(
            statement: Statement(
                conformityAverage: 0.75,
                conformityAverageDisplay: "75"),
            theme: WireframeTheme())
            .environment(\.locale, .init(identifier: "fr"))
            .wireframePreview()
    }
}

#endif
