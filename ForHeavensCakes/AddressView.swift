//
//  AddressView.swift
//  ForHeavensCakes
//
//  Created by Atin Agnihotri on 20/06/21.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var orderManager = OrderManager.getInstance()
    
    var submitDisabled: Bool {
        let nameCheck = orderManager.name.isEmpty
        let streetCheck = orderManager.streetAddress.count < 5
        let cityCheck = orderManager.city.count < 3
        let pinCodeCheck = (Int(orderManager.pinCode) == nil) || (orderManager.pinCode.count != 6)
        return nameCheck || streetCheck || cityCheck || pinCodeCheck
    }
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Name").font(.headline)) {
                    TextField("Name", text: $orderManager.name)
                }
                Section(header: Text("Street Address").font(.headline)) {
                    TextField("Street Address", text: $orderManager.streetAddress)
                }
                Section(header: Text("City").font(.headline)) {
                    TextField("City", text: $orderManager.city)
                }
                Section(header: Text("PIN Code").font(.headline)) {
                    TextField("PIN", text: $orderManager.pinCode)
                        .keyboardType(.numberPad)
                }
            }
            NavigationLink (
                destination: CheckoutView(),
                label: {
                    SubmitButtonView("Checkout")
                }
            ).disabled(submitDisabled)
            .colorMultiply(submitDisabled ? .secondary : Color(red: 1, green: 1, blue: 1))
            
        }.navigationBarTitle("Confirm Address Details", displayMode: .automatic)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView().preferredColorScheme(.dark)
    }
}
