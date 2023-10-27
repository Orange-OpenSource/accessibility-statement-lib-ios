/*
 * Software Name: accessibility-statement-lib-ios
 * SPDX-FileCopyrightText: Copyright (c) 2021-2023 Orange SA
 * SPDX-License-Identifier: Apache-2.0
 *
 * This software is distributed under the Apache License 2.0.
 */

import SwiftUI

struct CircularProgressView: View {
    
    // =======================
    // MARK: Stored Properties
    // =======================
    
    public var declarations: Declaration
    public let circleSize: CGFloat = 200
    public var selectedTheme: Theme
    
    public var body: some View {
        VStack {
            ZStack {
                /// Background for the progress bar
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
                        comment: ""
                    )
                    .replacingOccurrences(of: "@", with: declarations.conformityAverageDisplay)
                )
                .font(.body)
                .multilineTextAlignment(.center)
                .frame(width: 150, height: 150)
                .accessibilityHidden(true)
                
                
                /// Foreground or the actual progress bar
                Circle()
                    .trim(from: 0.0, to: min(declarations.conformityAverage, 1.0))
                    .stroke(style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round))
                    .foregroundColor(selectedTheme.color)
                
                    .rotationEffect(Angle(degrees: 270.0))
                    .animation(.linear, value: declarations.conformityAverage)
                    .frame(width: circleSize, height: circleSize)
            }
            
            Text(
                NSLocalizedString(
                    "result_declaration_subtitle",
                    tableName: nil,
                    bundle: .module,
                    value: "",
                    comment: ""
                )
                .replacingOccurrences(of: "@", with: declarations.conformityAverageDisplay)
            )
            .font(.body)
            .multilineTextAlignment(.center)
            .padding(.top, 10)
            .padding([.leading, .trailing], 30)
            
            Divider()
        }
    }
}

struct CircularProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressView(
            declarations: Declaration(
                conformityAverage: 0.75,
                conformityAverageDisplay: "75"
            ),
            selectedTheme: .sosh
        )
        .environment(\.locale, .init(identifier: "fr"))
    }
}

