//
//  ContentView.swift
//  CoreDataJSON
//
//  Created by Master Family on 17/09/2020.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: User.entity(), sortDescriptors: NSSortDescriptor(key: #keyPath(User.name), ascending: true)) var users: FetchedResults<User>
    
    
    var body: some View {
        
        
        List(users, id: \.self) {user in
            Text(user.name) ?? "Error"
        }.onAppear(perform: loadData)
            
    }
    
    func loadData() {
        
        if users.isEmpty {
            
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
                
                let decoder = JSONDecoder()
                decoder.userInfo[CodingUserInfoKey.context!] = self.moc
                decoder.dateDecodingStrategy = .iso8601
                
                _ = try! decoder.decode([User].self, from: data)
                
                
            }.resume()
        }
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

