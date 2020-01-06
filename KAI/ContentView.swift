//
//  ContentView.swift
//  KAI
//
//  Created by Ravil Vildanov on 03.01.2020.
//  Copyright © 2020 Ravil Vildanov. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    private let scheduleService = ScheduleServiceDefault()
    @State private var schedule: ScheduleResponseModel?
    
    var body: some View {
        view()
            .onAppear {
                self.scheduleService.requestGroupId(groupNumber: "4435", success: { (groupIdResponseModels) in
                    if let first = groupIdResponseModels.first {
                        self.scheduleService.requestSchedule(for: String(first.id), success: { (scheduleResponseModel) in
                            self.schedule = scheduleResponseModel
                        }, failure: { _ in })
                    }
                }, failure: { _ in })
        }
    }
    
    private func view() -> AnyView {
        if let schedule = schedule {
            let viewModel = WeekScheduleViewModel(scheduleResponseModel: schedule)
            return AnyView(WeekScheduleView(weekSchedule: viewModel))
        } else {
            return AnyView(Text("Loading"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
