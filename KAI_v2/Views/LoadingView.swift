//
//  LoadingView.swift
//  KAI_v2
//
//  Created by Ravil Vildanov on 08.02.2020.
//  Copyright © 2020 Ravil Vildanov. All rights reserved.
//

import SwiftUI

struct LoadingView: View {
    
    @State private var spin = false
    
    var body: some View {
        Image(systemName: "airplane")
            .resizable()
            .frame(width: 50, height: 50)
            .padding(.bottom, 120)
            .rotationEffect(.degrees(spin ? 360 : 0))
            .animation(
                Animation.linear(duration: 2.5)
                .repeatForever(autoreverses: false)
            )
            .onAppear {
                self.spin.toggle()
        }
    }
    
}


struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}

