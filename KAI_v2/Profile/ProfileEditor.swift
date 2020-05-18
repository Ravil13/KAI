//
//  ProfileEditor.swift
//  KAI_v2
//
//  Created by Ravil Vildanov on 11.05.2020.
//  Copyright © 2020 Ravil Vildanov. All rights reserved.
//

import SwiftUI

struct EditorField: View {
    
    var title: String
    
    @Binding var value: String
    
    var body: some View {
        HStack {
            Text(title).bold()
            Divider()
            TextField(title, text: $value)
        }
    }
}

struct ProfileEditor: View {
    
    @Binding var profile: Profile
    
    var body: some View {
        List {
            EditorField(title: "Имя", value: $profile.name)
            EditorField(title: "Фамилия", value: $profile.surname)
            EditorField(title: "Группа", value: $profile.group)
            
            VStack(alignment: .leading, spacing: 20) {
                Text("Дата рождения").bold()
                DatePicker(selection: $profile.birthDate) {
                    Text("Дата рождения")
                }
            }
        }
    }
}

struct ProfileEditor_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditor(profile: .constant(.default))
    }
}
