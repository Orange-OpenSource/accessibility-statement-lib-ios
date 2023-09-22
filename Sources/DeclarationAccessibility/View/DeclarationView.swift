//
//  SwiftUIView.swift
//
//
//  Created by Orange on 21/09/2023.
//

import SwiftUI

public struct DeclarationView: View {
    var declarations = Declaration()

    public init(xmlFileName: String) {
        let parser = DeclarationDataParser()
        parser.parseXML(fileName: xmlFileName)
        self.declarations = parser.declarations
    }
    
    public var body: some View {
        NavigationView {
            ScrollView {
                VStack() {
                    VStack {
                        CircularProgressView(declarations: declarations)
                            .frame(width: UIScreen.main.bounds.width)
                    }
                    .padding(.top, 15)

                    VStack {
                        InformationView(declarations: declarations)
                            .frame(width: UIScreen.main.bounds.width)
                    }
                }
            }
            .navigationBarTitle("Declaration")
        }
    }
}


public struct DeclarationView_Previews: PreviewProvider {
    public static var previews: some View {
        DeclarationView(xmlFileName: "")
    }
}

public struct CircularProgressView: View {
    
    var declarations: Declaration
    let circleSize: CGFloat = 200

    public var body: some View {
        VStack {
            ZStack {
                // Background for the progress bar
                Circle()
                    .stroke(lineWidth: 15)
                    .opacity(0.1)
                    .foregroundColor(.gray)
                    .frame(width: circleSize, height: circleSize)
                Text("\(declarations.conformityAverageDisplay)% compliant")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .frame(width: 150, height: 150)
                
                // Foreground or the actual progress bar
                Circle()
                    .trim(from: 0.0, to: min(declarations.conformityAverage, 1.0))
                    .stroke(style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round))
                    .foregroundColor(.orange)
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

///Seconf View
public struct InformationView: View {
    var declarations: Declaration
    public var body: some View {
        ScrollView {
            VStack(spacing: -20) {
                GroupView(title: "Date of Audit", subTitle: declarations.auditDate)
                    .accessibilityElement(children: .combine)
                GroupView(title: "Identity of the declarant", subTitle: declarations.identityName, text: declarations.identityAdresse)
                GroupView(title: "Repository", subTitle: declarations.referentialName)
                GroupView(title: "Application technology", subTitle: declarations.technologies)
            }
            
            HStack {
                Button(action: {
                    if let url = URL(string: declarations.detailUrl) {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("More details")
                        .padding()
                        .background(Color(UIColor.label))
                        .foregroundColor(Color(UIColor.systemBackground))
                }
            }
        }
    }
}



public struct GroupView: View {
    let title: String
    let subTitle: String
    let text: String?

    init(title: String, subTitle: String, text: String? = nil) {
        self.title = title
        self.subTitle = subTitle
        self.text = text
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.title3)
                .bold()
                .multilineTextAlignment(.leading) // Text alignment across multiple lines.
                .frame(maxWidth: .infinity, alignment: .leading) // Left text alignment.
            Text(subTitle)
                .font(.body)
            if let text = text, !text.isEmpty {
                Text(text)
                    .font(.body)
            }
        }
        .padding()
    }
}
