//
//  SubmitButtonView.swift
//  ForHeavensCakes
//
//  Created by Atin Agnihotri on 21/06/21.
//

import SwiftUI

struct SubmitButtonView: View {
    var text: String
    var buttonColor: Color = Color.green
    var paddingAmount: CGFloat = 10
    var cornerRadius: CGFloat = 10
    
    init(_ text: String) {
        self.text = text
    }
    
    init(_ text: String, color buttonColor: Color) {
        self.text = text
        self.buttonColor = buttonColor
    }
    
    init(_ text: String, cornerRadius: CGFloat) {
        self.text = text
        self.cornerRadius = cornerRadius
    }

    
    init(_ text: String, color buttonColor: Color, padding paddingAmount: CGFloat, cornerRadius: CGFloat) {
        self.text = text
        self.buttonColor = buttonColor
        self.paddingAmount = paddingAmount
        self.cornerRadius = cornerRadius
    }
    
    var body: some View {
        HStack(alignment: .center) {
            Spacer()
            Text(text)
                .foregroundColor(Color.primary)
                .font(.title)
                .bold()
                .padding(paddingAmount)
                .colorInvert()
                .frame(maxWidth: .infinity)
                .background(buttonColor)
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            Spacer()
        }
    }
}

struct SubmitButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SubmitButtonView("Some CTA")
    }
}
