//
//  ContentView.swift
//  Programming Jokes
//
//  Created by Aneesh Pushparaj on 7/28/21.
//

import SwiftUI

struct ContentView: View {
    @State private var jokes = [joke]()
    @State private var showingAlert = false
    var body: some View {
        NavigationView {
            List(jokes) { joke in
                NavigationLink(
                    destination: Text(joke.punchline)
                        .padding(),
                    label: {
                        Text(joke.setup)
                    })
            }
            .navigationBarTitle("Programming Jokes", displayMode: .inline)
        }
        .onAppear(perform: {
            getJokes()
        })
        .alert(isPresented: $showingAlert, content: {
            Alert(title: Text("Loading Error"),
                  message: Text("There was a problem loading the data"),
                  dismissButton: .default(Text("OK")))
        })
    }
    
    func getJokes() {
        let apiKey = "?rapidapi-key=4889f9e3f9msh837983776489b8cp12d1ddjsn0fb79206ee5b"
        let query = "https://dad-jokes.p.rapidapi.com/joke/type/programming\(apiKey)"
        if let url = URL(string: query) {
            if let data = try? Data(contentsOf: url) {
                let json = try! JSON(data: data)
                if json["success"] == true {
                    let contents = json["body"].arrayValue
                    for item in contents {
                        let setup = item["setup"].stringValue
                        let punchline = item["punchline"].stringValue
                        let joke = joke(setup: setup, punchline: punchline)
                        jokes.append(joke)
                    }
                    return
                }
            }
        }
        showingAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct joke: Identifiable {
    let id = UUID()
    var setup: String
    var punchline: String
}
