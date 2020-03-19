//
//  WeekPicker.swift
//  KAI_v2
//
//  Created by Ravil Vildanov on 19.01.2020.
//  Copyright © 2020 Ravil Vildanov. All rights reserved.
//

import SwiftUI

struct WeekPicker: View {
    
    @Binding var weekType: WeekType
    
    var body: some View {
        Picker(selection: $weekType, label: Text("Неделя")) {
            Text(CurrentDay.isWeekEven ? "Текущая четная" : "Текущая нечетная")
                .tag(CurrentDay.weekType)
            Text(CurrentDay.isWeekEven ? "Следующая нечетная" : "Следующая четная")
                .tag(CurrentDay.nextWeekType)
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding(.horizontal, 16)
    }
}

//struct WeekPicker_Previews: PreviewProvider {
//    static var previews: some View {
//        WeekPicker(weekType: )
//    }
//}
