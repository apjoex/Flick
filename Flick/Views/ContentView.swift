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
        case omdb
        
        var titleMessage: String {
            switch self {
            case .favourites:
                return "Search for flicks on OMDb and add them to your favourites"
            case .omdb:
                return "Try a different search term"
            }
        }
    }
    
    @State private var selectedFlick: Flick?
    @State private var searchQuery: String = ""
    @State private var searchScope = FlickScope.favourites
    @State private var omdbFlicks = [Flick]()
    @State private var settingsShown: Bool = false
    @State private var hiddenMovies: [String] = (UserDefaults.standard.array(forKey: "hiddenMovies") as? [String] ?? [])
    
    @StateObject private var networkObserver = NetworkObserver()
    
    @Environment(\.managedObjectContext) private var viewContext
    
    private var filterdFlicks: [Flick] {
        var flicks: [Flick]
        switch searchScope {
        case .favourites:
            flicks = fetchedFlicks()
        case .omdb:
            flicks = omdbFlicks.filter{ omdbFlick in
                !hiddenMovies.contains(omdbFlick.title)
            }
        }
        
        if !searchQuery.isEmpty {
            return flicks.filter { flick in
                flick.title.localizedCaseInsensitiveContains(searchQuery)
            }
        } else {
            return flicks
        }
    }
    
    var body: some View {
        NavigationSplitView {
            List(filterdFlicks, selection: $selectedFlick) { flick in
                NavigationLink(value: flick) {
                    FlickRow(flick: flick)
                        .contextMenu {
                            if searchScope == .omdb {
                                Button {
                                    hiddenMovies.append(flick.title)
                                } label: {
                                    Label("Hide from results", systemImage: "eye.slash")
                                }
                            }
                        }
                }
            }
            .listStyle(.sidebar)
            .overlay(content: {
                if filterdFlicks.isEmpty {
                    VStack(spacing: 10) {
                        Text("Nothing to display")
                            .font(.title2)
                            .bold()
                        Text(searchScope.titleMessage)
                            .frame(width: 300)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                }
            })
            .navigationTitle("Flicks")
            .toolbar(content: {
                ToolbarItemGroup(placement: ToolbarItemPlacement.navigationBarTrailing) {
                    Label(networkObserver.isConnected ? "Online" : "Offline", systemImage: "antenna.radiowaves.left.and.right")
                        .labelStyle(TitleAndIconLabelStyle())
                        .foregroundColor(networkObserver.isConnected ? Color.green : Color.red)
                    
                    Button {
                        settingsShown = true
                    } label: {
                        Label("Settings", systemImage: "gear")
                            .labelStyle(.iconOnly)
                    }
                    
                }
            })
            .searchable(text: $searchQuery, prompt: "Search favourites, OMDb")
            .searchScopes($searchScope) {
                Text("Your Favourites").tag(FlickScope.favourites)
                Text("OMDb").tag(FlickScope.omdb)
            }
            .onSubmit(of: .search) {
                searchOMDB()
            }
            .onChange(of: searchQuery) { _ in
                searchOMDB()
            }
            .onChange(of: hiddenMovies) { newValue in
                UserDefaults.standard.set(newValue, forKey: "hiddenMovies")
            }
            .onAppear {
                networkObserver.start()
            }
        } detail: {
            if let selectedFlick {
                FlickDetailView(flick: selectedFlick)
            } else {
                VStack {
                    FlickPoster(url: "")
                        .frame(width: 200, height: 220)
                    Text("Sample Flick")
                        .font(.title3)
                        .bold()
                    Text("5.0")
                }
                .redacted(reason: .placeholder)
            }
        }
        .sheet(isPresented: $settingsShown) {
            List {
                Section {
                    ForEach(hiddenMovies, id: \.self) { title in
                        Text(title)
                            .swipeActions(edge: .trailing) {
                                Button {
                                    if let idx = hiddenMovies.firstIndex(of: title) {
                                        hiddenMovies.remove(at: idx)
                                    }
                                } label: {
                                    Label("Unhide", systemImage: "eye")
                                        .labelStyle(.titleOnly)
                                }
                            }
                    }
                } header: {
                    Text("Hidden movies")
                        .padding(.top, 30)
                } footer: {
                    if !hiddenMovies.isEmpty {
                        Text("Swipe left on a movie to unhide from search results")
                    }
                }
            }
            .listStyle(.insetGrouped)
            .presentationDetents([.medium, .large])
        }
    }
    
    func searchOMDB() {
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
                // Handle error better here
            }
        }
    }
    
    func fetchedFlicks() -> [Flick] {
        let request = FlickEntity.fetchRequest()
        let entities = (try? viewContext.fetch(request) as [FlickEntity]) ?? []
        return entities.map { entity in
            return Flick(entity: entity)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
