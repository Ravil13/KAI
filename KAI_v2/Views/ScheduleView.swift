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
    @State private var weekType: WeekType = .even
    
    var body: some View {
        NavigationView {
            VStack {
                Picker(selection: $weekType, label: Text("Неделя")) {
                    Text("Четная").tag(WeekType.even)
                    Text("Нечетная").tag(WeekType.odd)
                }
                .pickerStyle(SegmentedPickerStyle())
                scheduleList(for: weekType)
                .listStyle(GroupedListStyle())
                .navigationBarTitle("Расписание")
            }
        }
    }
    
    func scheduleList(for weekType: WeekType) -> AnyView {
        switch weekType {
        case .even:
            return AnyView(ScheduleList(schedules: viewModel.evenSchedules))
        case .odd:
            return AnyView(ScheduleList(schedules: viewModel.oddSchedules))
        }
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView(viewModel: ScheduleViewModel())
    }
}
