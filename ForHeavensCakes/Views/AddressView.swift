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
        let nameCheck = orderManager.order.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        let streetCheck = orderManager.order.streetAddress.trimmingCharacters(in: .whitespacesAndNewlines).count < 5
        let cityCheck = orderManager.order.city.trimmingCharacters(in: .whitespacesAndNewlines).count < 3
        let pinCodeCheck = (Int(orderManager.order.pinCode) == nil) || (orderManager.order.pinCode.trimmingCharacters(in: .whitespacesAndNewlines).count != 6)
        return nameCheck || streetCheck || cityCheck || pinCodeCheck
    }
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Name").font(.headline)) {
                    TextField("Name", text: $orderManager.order.name)
                }
                Section(header: Text("Street Address").font(.headline)) {
                    TextField("Street Address", text: $orderManager.order.streetAddress)
                }
                Section(header: Text("City").font(.headline)) {
                    TextField("City", text: $orderManager.order.city)
                }
                Section(header: Text("PIN Code").font(.headline)) {
                    TextField("PIN", text: $orderManager.order.pinCode)
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
