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

    /// Target visual size of the indicator, larger than OUDS's fixed native size (see `Self.nativeIndicatorSize`)
    private static let indicatorSize: CGFloat = 200
    /// Fixed internal size of `OUDSCircularProgressIndicator`, used as the base for `scaleEffect`
    private static let nativeIndicatorSize: CGFloat = 48

    var body: some View {
        VStack {
            OUDSCircularProgressIndicator(progress: Double(min(statement.conformityAverage, 1.0)), status: .accent)
                .scaleEffect(Self.indicatorSize / Self.nativeIndicatorSize)
                .frame(width: Self.indicatorSize, height: Self.indicatorSize)
                .overlay {
                    OUDSBody(text: NSLocalizedString(
                        "average_title_label",
                        tableName: nil,
                        bundle: .module,
                        value: "",
                        comment: "")
                        .replacingOccurrences(of: "@", with: statement.conformityAverageDisplay),
                    size: .large,
                    weight: .default)
                        .multilineTextAlignment(.center)
                        .accessibilityHidden(true)
                }

            OUDSBody(text:
                NSLocalizedString(
                    "result_declaration_subtitle",
                    tableName: nil,
                    bundle: .module,
                    value: "",
                    comment: "")
                    .replacingOccurrences(of: "@", with: statement.conformityAverageDisplay),
                size: .large,
                weight: .default)
                .multilineTextAlignment(.center)
                .padding(.top, theme.spaces.fixedSmall)
                .padding([.leading, .trailing], theme.spaces.fixedXlarge)

            OUDSHorizontalDivider(color: .default)
        }
    }
}

// MARK: - Xcode Preview

#if DEBUG
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

#endif
