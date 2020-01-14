//
//  LessonView.swift
//  KAI_v2
//
//  Created by Ravil Vildanov on 07.01.2020.
//  Copyright © 2020 Ravil Vildanov. All rights reserved.
//

import SwiftUI

struct LessonView: View {
    
    @ObservedObject var lesson: LessonViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(lesson.disciplName).font(.headline)
            Text("\(lesson.dayTime) \(lesson.disciplType) в \(lesson.buildNum), \(lesson.audNum), \(lesson.dayDate)")
        }
    }
}

//struct LessonView_Previews: PreviewProvider {
//    static var previews: some View {
//        LessonView(lesson: )
//    }
//}
