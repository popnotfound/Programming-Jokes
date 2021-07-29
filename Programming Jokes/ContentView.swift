//
//  ContentView.swift
//  Programming Jokes
//
//  Created by Aneesh Pushparaj on 7/28/21.
//

import SwiftUI

struct ContentView: View {
    @State private var jokes = [joke]()
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
            .navigationTitle("Programming Jokes")
        }
        .onAppear(perform: {
            getJokes()
        })
    }
    
    func getJokes() {
        let apiKey = "?rapidapi-key = 4889f9e3f9msh837983776489b8cp12d1ddjsn0fb79206ee5b"
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
