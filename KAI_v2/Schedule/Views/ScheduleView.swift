//
//  ScheduleView.swift
//  KAI_v2
//
//  Created by Ravil Vildanov on 07.01.2020.
//  Copyright © 2020 Ravil Vildanov. All rights reserved.
//

import SwiftUI

struct ScheduleView: View {
    
    @ObservedObject var viewModel: ScheduleViewModel
    @State private var weekType: WeekType = CurrentDay.weekType
    @State var showingProfile = UserDefaults.standard.string(forKey: "group") == nil
    
    var profileButton: some View {
        Button(action: { self.showingProfile.toggle() }) {
            Image(systemName: "person.crop.circle")
                .imageScale(.large)
                .accessibility(label: Text("User Profile"))
                .padding()
        }
    }

    
    var body: some View {
        NavigationView {
            if viewModel.isLoading {
                LoadingView()
            }
            
            if viewModel.showingError {
                VStack(alignment: .center) {              
                    Text("При загрузке данных произошла ошибка, попробуйте позже").lineLimit(0)
                    Button(action: {
                        self.viewModel.loadSchedule(for: UserDefaults.standard.string(forKey: "group") ?? "")
                    }) {
                        Text("Повторить попытку")
                    }
                }
            }
            
            VStack {
                WeekPicker(weekType: $weekType)
                ScheduleList(schedules: viewModel.schedules, weekType: weekType)
            }
            .navigationBarTitle("Расписание")
            .navigationBarItems(trailing: profileButton)
            .sheet(isPresented: $showingProfile) {
                ProfileView()
                    .onDisappear {
                        self.viewModel.loadSchedule(for: UserDefaults.standard.string(forKey: "group") ?? "")
                }
            }
        }
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView(viewModel: ScheduleViewModel())
    }
}
