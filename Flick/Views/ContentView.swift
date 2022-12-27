//
//  ContentView.swift
//  Flick
//
//  Created by JOSEPH AKINDE-PETERS on 22.12.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedFlick: Flick?
    @State private var searchQuery: String = ""
    
    private var flicks: [Flick] {
        let allFlicks = Flick.sample
        if !searchQuery.isEmpty {
            return allFlicks.filter { flick in
                flick.title.localizedCaseInsensitiveContains(searchQuery) ||
                flick.plot.localizedCaseInsensitiveContains(searchQuery)
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
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                //remove from favs
                            } label: {
                                Label("Delete", systemImage: "trash")
                                    .labelStyle(IconOnlyLabelStyle())
                            }
                            
                        }
                }
            }
            .listStyle(.sidebar)
            .navigationTitle("Flicks")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        
                    } label: {
                        Label("Add flick", systemImage: "plus.circle.fill")
                            .labelStyle(TitleAndIconLabelStyle())
                    }
                }
            })
            .searchable(text: $searchQuery, prompt: "Search")
        } detail: {
            NavigationStack {
                Text("Details gooes here for \(selectedFlick?.title ?? "")")
                    .navigationTitle(selectedFlick?.title ?? "")
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
