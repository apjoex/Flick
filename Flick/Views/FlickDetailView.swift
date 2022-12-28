//
//  FlickDetailView.swift
//  Flick
//
//  Created by JOSEPH AKINDE-PETERS on 27.12.2022.
//

import SwiftUI

struct FlickDetailView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) var favourites: FetchedResults<FlickEntity>
    
    var flick: Flick
    
    var body: some View {
        let layout =  horizontalSizeClass == .regular ? AnyLayout(HStackLayout(alignment: .top)) : AnyLayout(VStackLayout())
        
        ScrollView {
            layout {
                VStack(spacing: 10) {
                    FlickPoster(url: flick.poster)
                        .frame(width: 200)
                    
                    Text(flick.title)
                        .font(.title3)
                        .bold()
                    
                    HStack {
                        Image(systemName: "star.fill")
                            .imageScale(.small)
                            .symbolRenderingMode(.multicolor)
                        
                        Text(flick.rating)
                    }
                }
                GroupBox {
                    Text(flick.plot)
                }
            }
            .padding()
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    if favourites.contains(where: { f in
                        (f.id ?? "") == flick.id
                    }) {
                        Button(role: .destructive) {
                            if let fav: FlickEntity = favourites.first(where: { f in
                                (f.id ?? "") == flick.id
                            }) {
                                print("E SUPPOSE DELETE O")
                                viewContext.delete(fav)
                                try? viewContext.save()
                            } else {
                                print("E NEVER DELETE O")
                            }
                        } label: {
                            Label("Remove", systemImage: "minus.circle")
                                .labelStyle(.titleAndIcon)
                        }
                        .buttonStyle(.bordered)
                        
                    } else {
                        Button {
                            let newFlick = FlickEntity(context: viewContext)
                            newFlick.id = flick.id
                            newFlick.title = flick.title
                            newFlick.plot = flick.plot
                            newFlick.poster = flick.poster
                            newFlick.rating = flick.rating
                            do {
                                try viewContext.save()
                            } catch {
                                fatalError("An error occured: \(error as NSError)")
                            }
                    } label: {
                        Label("Add", systemImage: "plus.circle")
                            .labelStyle(.titleAndIcon)
                    }
                    .buttonStyle(.bordered)
                }
            }
        }
            .navigationTitle(flick.title )
        .navigationBarTitleDisplayMode(.inline)
    }
}
}

struct FlickDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FlickDetailView(flick: Flick.sample)
    }
}
