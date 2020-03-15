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
    
    var isLoading: Bool {
        viewModel.state == .loading
    }
    
    var isFailed: Bool {
        viewModel.state == .failed
    }
    
    var body: some View {
        NavigationView {
            if isLoading {
                LoadingView()
            }
            
            if isFailed {
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
