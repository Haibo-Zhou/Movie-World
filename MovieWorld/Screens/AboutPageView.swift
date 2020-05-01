//
//  AboutPageView.swift
//  MovieWorld
//
//  Created by Chuck.Zhou on 5/1/20.
//  Copyright © 2020 Haibo Family. All rights reserved.
//

import SwiftUI

struct AboutPageView: View {
    
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            Image("app_icon_transparent_bg")
            VStack(alignment: .leading, spacing: 12) {
                Text("Welcome")
                    .font(.system(size: 30, weight: .black, design: .rounded))
                Text("App intro")
                .fixedSize(horizontal: false, vertical: true)
                
                VStack(alignment: .leading) {
                    Text("Notice")
                        .font(.headline)
                        .foregroundColor(.red)
                    Text("TMDb attribute")
                        .fixedSize(horizontal: false, vertical: true)
                    Image("tmdb_primary_long")
                }
                .padding(.bottom)
                
                VStack(alignment: .leading) {
                    Text("Contact me")
                    Text("Email")
                        .font(.system(.headline, design: .rounded))
                }  
            }
        }.padding(.horizontal).padding(.bottom)
        
        
        
    }
}

struct AboutPageView_Previews: PreviewProvider {
    static var previews: some View {
        AboutPageView()
    }
}
