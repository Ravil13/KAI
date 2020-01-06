//
//  DayScheduleView.swift
//  KAI
//
//  Created by Ravil Vildanov on 06.01.2020.
//  Copyright © 2020 Ravil Vildanov. All rights reserved.
//

import SwiftUI

struct DayScheduleView: View {
    
    @State var daySchedule: DayScheduleViewModel
    
    var body: some View {
        List {
            Section(header: Text("")) {
                ForEach(daySchedule.lessons, id: \.self) { lesson in
                    DetailLessonView(lesson: lesson)
                }
            }
        }
        .navigationBarTitle(Text(daySchedule.day))
    }
}

struct DayScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        DayScheduleView(daySchedule: .mock)
    }
}
