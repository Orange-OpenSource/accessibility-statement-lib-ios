//
// MIT License
// Copyright (c) 2023 Orange
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the  Software), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//

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
            selectedTheme: .innovation
        )
        .environment(\.locale, .init(identifier: "fr"))
    }
}

