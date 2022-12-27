//
//  FlickDetailView.swift
//  Flick
//
//  Created by JOSEPH AKINDE-PETERS on 27.12.2022.
//

import SwiftUI

struct FlickDetailView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
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
        }
    }
}

struct FlickDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let flick = Flick.sample.first!
        FlickDetailView(flick: flick)
    }
}
