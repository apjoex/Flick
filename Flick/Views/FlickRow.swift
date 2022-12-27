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
            AsyncImage(url: URL(string: flick.poster)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
            } placeholder: {
                Color.gray
            }
            .frame(width: 70)
            .cornerRadius(6.0)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(flick.title)
                    .font(.title3)
                    .bold()
                
                Text(flick.plot)
                    .font(.body)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                
                HStack {
                    Image(systemName: "star.fill")
                        .imageScale(.small)
                        .symbolRenderingMode(.multicolor)
                    
                    Text(String(describing: flick.rating))
                }
            }
        }
        .padding()
    }
}

struct FlickRow_Previews: PreviewProvider {
    static var previews: some View {
        let flick = Flick.sample.first!
        FlickRow(flick: flick)
    }
}
