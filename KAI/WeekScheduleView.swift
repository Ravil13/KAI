//
//  WeekSchedule.swift
//  KAI
//
//  Created by Ravil Vildanov on 06.01.2020.
//  Copyright © 2020 Ravil Vildanov. All rights reserved.
//

import SwiftUI

struct WeekScheduleView: View {
    
    @State var weekSchedule: WeekScheduleViewModel
    
    var body: some View {
        NavigationView {
            List() {
                ForEach(weekSchedule.daySchedules, id: \.self) { daySchedule in
                    Section(header: Text(daySchedule.day)) {
                        ForEach(daySchedule.lessons, id: \.self) { lesson in
                            NavigationLink(destination: DayScheduleView(daySchedule: daySchedule)) {
                                LessonView(lesson: lesson)
                            }
                        }
                    }
                }
            }
        .listStyle(GroupedListStyle())
        .navigationBarTitle("Расписание")
        }
    }
}

struct WeekScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        WeekScheduleView(weekSchedule: .mock)
    }
}
