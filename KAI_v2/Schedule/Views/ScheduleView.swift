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
    
    var body: some View {
        NavigationView {
            if viewModel.isLoading {
                LoadingView()
            }
            
            if viewModel.showingError {
                VStack(alignment: .center) {              
                    Text("При загрзке данных произошла ошибка, попробуйте позже")
                }
            }
            
            VStack {
                WeekPicker(weekType: $weekType)
                ScheduleList(schedules: viewModel.schedules, weekType: weekType)
            }
            .navigationBarTitle("Расписание")
        }
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView(viewModel: ScheduleViewModel())
    }
}
