//
//  ContentView.swift
//  ForHeavensCakes
//
//  Created by Atin Agnihotri on 20/06/21.
//

import SwiftUI

class User: ObservableObject, Codable {
    
    enum CodingKeys: CodingKey {
        case name
    }
    
    @Published var name = "User TestUser"
    
    required init(from decoder: Decoder) throws {
        let containter = try decoder.container(keyedBy: CodingKeys.self)
        name = try containter.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.name, forKey: .name)
    }
}

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct ContentView: View {
    @State var results = [Result]()
    @State private var userName = ""
    @State private var emailId = ""
    var disabledForm : Bool {
        userName.count < 5 || emailId.count < 5
    }
    var body: some View {
        Form {
            Section {
                TextField("Username", text: $userName)
                TextField("Email", text: $emailId)
            }
            
            Section {
                Button("Sign up") {
                    print("Creating Account . . . ")
                }.disabled(disabledForm)
            }
        }
//        List(results, id:\.trackId) { result in
//            VStack (alignment: .leading) {
//                Text(result.trackName).font(.headline)
//                Text(result.collectionName)
//            }.padding()
//        }.onAppear(perform: loadDataFromItunes)
    }
    
    func loadDataFromItunes() {
        guard let url = URL(string: "https://itunes.apple.com/search?term=kendrik+lamar&entity=song") else {
            print("Could Not load data from iTunes. Thanks Tim Apple!")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedData = try? JSONDecoder().decode(Response.self, from: data) {
                    DispatchQueue.main.async {
                        self.results = decodedData.results
                    }
                    
                    return
                }
            }
            
            print("Fetch failed :: \(error?.localizedDescription ?? "Unknown Error")")
        }.resume()
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
