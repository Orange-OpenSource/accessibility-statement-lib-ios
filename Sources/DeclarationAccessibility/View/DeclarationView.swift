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
            GeometryReader { geometry in // oriantation
                ScrollView {
                    VStack() {
                        VStack {
                            CircularProgressView(declarations: declarations)
                                .frame(width: geometry.size.width)
                        }
                        .padding(.top, 15)

                        VStack {
                            InformationView(declarations: declarations)
                                .frame(width: geometry.size.width)
                        }
                    }
                }
                .navigationBarTitle("Declaration")
            }
        }
    }
}


public struct DeclarationView_Previews: PreviewProvider {
    public static var previews: some View {
        DeclarationView(xmlFileName: "")
    }
}
