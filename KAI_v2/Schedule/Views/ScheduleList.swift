//
//  ScheduleList.swift
//  KAI_v2
//
//  Created by Ravil Vildanov on 21.01.2020.
//  Copyright © 2020 Ravil Vildanov. All rights reserved.
//

import SwiftUI

struct HeaderView: View {
    let text: Text
    
    var body: some View {
        HStack {
            text.font(.headline).bold()
            .padding(.horizontal, 16)
            Spacer()
        }
        .frame(height: 50)
    }
}

struct ScheduleList: View {
    
    var schedules: [DayScheduleViewModel]
    var weekType: WeekType
    
    var body: some View {
        List {
            ForEach(schedules) { schedule in
                HeaderView(text: Text(schedule.day.rawValue))
                    .listRowBackground((Color("tableViewBackground")))
                
                ForEach(schedule.lessons) { lesson in
                    if lesson.dayDate != self.weekType.opposite.rawValue {
                        LessonView(lesson: lesson)
                    }
                }
                .listRowBackground(Color("cellCollor"))
                .padding(.horizontal, 20)
            }
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
    }
}

struct ScheduleList_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleList(schedules: [], weekType: .even)
    }
}
