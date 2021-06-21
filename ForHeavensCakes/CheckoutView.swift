//
//  CheckoutView.swift
//  ForHeavensCakes
//
//  Created by Atin Agnihotri on 21/06/21.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var orderManager = OrderManager.getInstance()
    
    var billText: LocalizedStringKey {
        "Your total bill is $\(orderManager.cost, specifier: "%.2f")"
    }
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(.vertical) {
                VStack (alignment: .center) {
                    VStack {
                        Image("cupcakes")
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: geo.size.width)
                        Text(billText)
                            .padding()
                            .font(.title)
                        
                    }
                    Spacer(minLength: 50)
                    // todo Make the Button stick to bottom like the rest of the CTAs
                    Button (action: {
                        
                    },
                    label: {
                        SubmitButtonView("Checkout")
                    })
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
        }.navigationBarTitle("Checkout", displayMode: .inline)
    }
    
    func checkoutOrder() {
        
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView()
    }
}
