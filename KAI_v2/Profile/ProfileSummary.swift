//
//  ProfileSummary.swift
//  KAI_v2
//
//  Created by Ravil Vildanov on 11.05.2020.
//  Copyright © 2020 Ravil Vildanov. All rights reserved.
//

import SwiftUI

struct ProfileSummary: View {
    
    var profile: Profile
    
     static let formatter: DateFormatter = {
           let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yyyy"
           return formatter
       }()
    
    var body: some View {
        List {
            Text(profile.fullName)
                .bold()
                .font(.title)
            
            Text("Группа: \(profile.group)")
            
            Text("Дата рождения: \(profile.birthDate, formatter: Self.formatter)")
        }
    }
}

struct ProfileSummary_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSummary(profile: .default)
    }
}
