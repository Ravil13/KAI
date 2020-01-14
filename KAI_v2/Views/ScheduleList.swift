//
//  ScheduleList.swift
//  KAI_v2
//
//  Created by Ravil Vildanov on 14.01.2020.
//  Copyright © 2020 Ravil Vildanov. All rights reserved.
//

import SwiftUI

struct ScheduleList: View {
    
    var schedules: [DayScheduleViewModel] = []
    
    var body: some View {
        List {
            ForEach(schedules) { schedule in
                Section(header: Text(schedule.day.rawValue)) {
                    ForEach(schedule.lessons) { lesson in
                        LessonView(lesson: lesson)
                    }
                }
            }
        }
        .listStyle(GroupedListStyle())
    }
}

struct ScheduleList_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleList()
    }
}
