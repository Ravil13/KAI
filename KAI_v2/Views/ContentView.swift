//
//  ContentView.swift
//  KAI_v2
//
//  Created by Ravil Vildanov on 07.01.2020.
//  Copyright © 2020 Ravil Vildanov. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ScheduleView(viewModel: ScheduleViewModel())
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Расписание")
            }
            
            Text("Новости")
                .tabItem {
                    Image(systemName: "person.2.square.stack")
                    Text("Новости")
            }
            
            Text("Карта")
                .tabItem {
                    Image(systemName: "map")
                    Text("Карта")
            }
            
            Text("Настройки")
                .tabItem {
                    Image(systemName: "gear")
                    Text("Настройки")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}