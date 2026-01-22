// Software Name: accessibility-statement-lib-ios
// SPDX-FileCopyrightText: Copyright (c) Orange SA
// SPDX-License-Identifier: Apache-2.0
//
// This software is distributed under the Apache 2.0 license,
// the text of which is available at https://opensource.org/license/apache-2-0
// or see the "LICENSE" file for more details.

import SwiftUI

/// A `View` to define a circle which can be empty, a bit empty or not
struct CircularProgressView: View {

    var statement: Statement
    var theme: Theme

    private let circleSize: CGFloat = 200

    var body: some View {
        VStack {
            ZStack {
                // Background for the progress bar
                Circle()
                    .stroke(lineWidth: 15)
                    .opacity(0.3)
                    .foregroundColor(Color(UIColor.systemGray))
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
                .font(.body)
                .multilineTextAlignment(.center)
                .frame(width: 150, height: 150)
                .accessibilityHidden(true)

                // Foreground for the actual progress bar
                Circle()
                    .trim(from: 0.0, to: min(statement.conformityAverage, 1.0))
                    .stroke(style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round))
                    .foregroundColor(theme.color)
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
            .font(.body)
            .multilineTextAlignment(.center)
            .padding(.top, 10)
            .padding([.leading, .trailing], 30)

            Divider()
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
            theme: .sosh)
            .environment(\.locale, .init(identifier: "fr"))
    }
}
