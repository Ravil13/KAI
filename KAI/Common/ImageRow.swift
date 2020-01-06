//
//  ImageRow.swift
//  KAI
//
//  Created by Ravil Vildanov on 06.01.2020.
//  Copyright © 2020 Ravil Vildanov. All rights reserved.
//

import SwiftUI

struct ImageRow: View {
    
    var image: Image
    var text: Text
    
    var body: some View {
        HStack {
            image
            text
        }
    }
}

struct ImageRow_Previews: PreviewProvider {
    static var previews: some View {
        ImageRow(image: Image(systemName: "clock"), text: Text("8:00"))
    }
}
