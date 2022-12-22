//
//  FlickRow.swift
//  Flick
//
//  Created by JOSEPH AKINDE-PETERS on 22.12.2022.
//

import SwiftUI

struct FlickRow: View {
    var flick: Flick
    
    var body: some View {
        HStack (spacing: 10) {
            Image(systemName: "play.tv.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50)
            
            VStack(alignment: .leading) {
                Text(flick.title)
                    .font(.title2)
                    .bold()
                
                Text(flick.details)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
            }
        }
        .padding()
    }
}

struct FlickRow_Previews: PreviewProvider {
    static var previews: some View {
        let flick = Flick(id: 3, title: "Flick title", details: "Flick details")
        FlickRow(flick: flick)
    }
}
