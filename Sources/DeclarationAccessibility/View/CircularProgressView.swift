//
//  SwiftUIView.swift
//  
//
//  Created by Tayeb SEDRAIA on 22/09/2023.
//

import SwiftUI

struct CircularProgressView: View {
    var declarations: Declaration
    let circleSize: CGFloat = 200

    public var body: some View {
        VStack {
            ZStack {
                // Background for the progress bar
                Circle()
                    .stroke(lineWidth: 15)
                    .opacity(0.3)
                    .foregroundColor(Color(UIColor.systemGray))
                    .frame(width: circleSize, height: circleSize)
                Text("\(declarations.conformityAverageDisplay)% compliant")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .frame(width: 150, height: 150)
                    .accessibilityHidden(true)
                
                // Foreground or the actual progress bar
                Circle()
                    .trim(from: 0.0, to: min(declarations.conformityAverage, 1.0))
                    .stroke(style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round))
                    .foregroundColor(Color(UIColor(red: 0.883, green: 0.463, blue: 0.176, alpha: 1)))
                    .rotationEffect(Angle(degrees: 270.0))
                    .animation(.linear, value: declarations.conformityAverage)
                    .frame(width: circleSize, height: circleSize)
            }
            Text("This application is \(declarations.conformityAverageDisplay)% compliant with WCAG criteria")
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
        CircularProgressView(declarations: Declaration(
            conformityAverage: 0.75,
            conformityAverageDisplay: "75%"
        ))
    }
}
