//
//  ProfileView.swift
//  KAI_v2
//
//  Created by Ravil Vildanov on 18.05.2020.
//  Copyright © 2020 Ravil Vildanov. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    
    @State private var name: String = UserDefaults.standard.string(forKey: "name") ?? ""
    @State private var surname: String = UserDefaults.standard.string(forKey: "surname") ?? ""
    @State private var group: String = UserDefaults.standard.string(forKey: "group") ?? ""
    
    var body: some View {
        List {
            Text("Профиль")
            .bold()
            .font(.title)
            .offset()
            
            HStack {
                Text("Имя: ")
                Spacer()
                TextField("Имя", text: $name)
            }
            
            HStack {
                Text("Фамилия: ")
                Spacer()
                TextField("Фамилия", text: $surname)
            }
            
            HStack {
                Text("Группа: ")
                Spacer()
                TextField("Группа", text: $group)
            }
        }.onDisappear {
            UserDefaults.standard.set(self.name, forKey: "name")
            UserDefaults.standard.set(self.surname, forKey: "surname")
            UserDefaults.standard.set(self.group, forKey: "group")
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
