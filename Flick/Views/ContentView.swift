//
//  ContentView.swift
//  Flick
//
//  Created by JOSEPH AKINDE-PETERS on 22.12.2022.
//

import SwiftUI

struct ContentView: View {
    enum FlickScope: String {
        case favourites
        case Omdb
    }
    
    @State private var selectedFlick: Flick?
    @State private var searchQuery: String = ""
    @State private var searchScope = FlickScope.favourites
    @State private var omdbFlicks = [Flick]()
    
    private var emptyViewTitle: String {
        switch searchScope {
        case .favourites:
            return "No flicks to display"
        case .Omdb:
            return "No result"
        }
    }
    
    private var emptyViewSubtitle: String {
        switch searchScope {
        case .favourites:
            return "Search for flicks on OMDb and add them to your favourites"
        case .Omdb:
            return "Try a different search term"
        }
    }
    
    private var flicks: [Flick] {
        var allFlicks: [Flick]
        switch searchScope {
        case .favourites:
            allFlicks = Flick.sample
        case .Omdb:
            allFlicks = omdbFlicks
        }
        
        if !searchQuery.isEmpty {
            return allFlicks.filter { flick in
                flick.title.localizedCaseInsensitiveContains(searchQuery)
            }
        } else {
            return allFlicks
        }
    }
    
    var body: some View {
        NavigationSplitView {
            List(flicks, selection: $selectedFlick) { flick in
                NavigationLink(value: flick) {
                    FlickRow(flick: flick)
                }
            }
            .listStyle(.sidebar)
            .overlay(content: {
                if flicks.isEmpty {
                    VStack {
                        Text(emptyViewTitle)
                            .font(.title2)
                            .bold()
                        Text(emptyViewSubtitle)
                            .frame(width: 300)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                }
            })
            .navigationTitle("Flicks")
            .searchable(text: $searchQuery, prompt: "Search favourites, OMDb")
            .searchScopes($searchScope) {
                Text("Your Favourites").tag(FlickScope.favourites)
                Text("OMDb").tag(FlickScope.Omdb)
            }
            .onSubmit(of: .search) {
                searchIMDB()
            }
        } detail: {
            NavigationStack {
                Text("Details gooes here for \(selectedFlick?.title ?? "")")
                    .navigationTitle(selectedFlick?.title ?? "")
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
    
    func searchIMDB() {
        Task {
            var url = URL(string: "https://www.omdbapi.com/")!
            let requestParams = [
                URLQueryItem(name: "apikey", value: "d76fba06"),
                URLQueryItem(name: "T", value: searchQuery)
            ]
            url.append(queryItems: requestParams)
            let request = URLRequest(url: url)
            do {
                let (data, _) = try await URLSession.shared.data(for: request)
                if let result = try? JSONDecoder().decode(Flick.self, from: data) {
                    omdbFlicks = [result]
                }
                
            } catch {
                omdbFlicks = []
                print("ERROR \(error)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
