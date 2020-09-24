//
//  ContentView.swift
//  CoreDataJSON
//
//  Created by Master Family on 17/09/2020.
//

import SwiftUI

struct ContentView: View {
    
    @State private var users: [UserJSON] = []
    
    var body: some View {
        
        NavigationView {
            List(users, id: \.id) { user in
                Text(user.name)
            }.onTapGesture(perform: loadData)
            .navigationTitle("CoreDataJSON")
        }
    }
    
    func loadData() {
        
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                fatalError("Network error: " + error.localizedDescription)
            }
            
            guard (response as? HTTPURLResponse) != nil else {
                fatalError("Not a HTTP response")
            }
            
            guard let data = data else {
                fatalError("No HTTP data")
            }
            
            if let decodedResponse = try? JSONDecoder().decode([UserJSON].self, from: data) {
                DispatchQueue.main.async {
                    self.users = decodedResponse
                    
                }
            }
            
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
