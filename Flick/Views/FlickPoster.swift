//
//  FlickPoster.swift
//  Flick
//
//  Created by JOSEPH AKINDE-PETERS on 27.12.2022.
//

import SwiftUI

struct FlickPoster: View {
    var url: String
    
    var body: some View {
        AsyncImage(url: URL(string: url)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
            
        } placeholder: {
            Color.gray
                .opacity(0.6)
        }
        .cornerRadius(6.0)
    }
}

struct FlickPoster_Previews: PreviewProvider {
    static var previews: some View {
        FlickPoster(url: "")
    }
}
