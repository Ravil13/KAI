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
            
            NewsView()
                .tabItem {
                    Image(systemName: "person.2.square.stack")
                    Text("Новости")
            }
            
            if #available(iOS 14.0, *) {
                MapView()
                    .tabItem {
                        Image(systemName: "map")
                        Text("Карта")
                    }
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }
}

 
