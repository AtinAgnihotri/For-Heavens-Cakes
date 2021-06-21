//
//  AddressView.swift
//  ForHeavensCakes
//
//  Created by Atin Agnihotri on 20/06/21.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var orderManager = OrderManager.getInstance()
    @State private var name = ""
    @State private var streetAddress = ""
    @State private var city = ""
    @State private var pinCode = ""
    
    var submitDisabled: Bool {
        let nameCheck = name.isEmpty
        let streetCheck = streetAddress.count < 5
        let cityCheck = city.count < 3
        let pinCodeCheck = (Int(pinCode) == nil) || (pinCode.count != 6)
        return nameCheck || streetCheck || cityCheck || pinCodeCheck
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Name").font(.headline)) {
                        TextField("Name", text: $name)
                    }
                    Section(header: Text("Street Address").font(.headline)) {
                        TextField("Street Address", text: $streetAddress)
                    }
                    Section(header: Text("City").font(.headline)) {
                        TextField("City", text: $city)
                    }
                    Section(header: Text("PIN Code").font(.headline)) {
                        TextField("PIN", text: $pinCode)
                            .keyboardType(.numberPad)
                    }
                    
                    
                }
                NavigationLink (
                    destination: Text("Proceed to order"), // stub
                    label: {
                        HStack (alignment: .center) {
                            Spacer()
                            Text("Confirm Order").foregroundColor(Color.accentColor)
                                .font(.title)
                                .bold()
                            Spacer()
                        }
                    }
                ).disabled(submitDisabled)
                
            }.navigationBarTitle("Confirm Address Details", displayMode: .inline)

        }
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView()
    }
}
