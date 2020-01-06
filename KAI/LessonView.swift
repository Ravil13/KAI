//
//  LessonView.swift
//  KAI
//
//  Created by Ravil Vildanov on 06.01.2020.
//  Copyright © 2020 Ravil Vildanov. All rights reserved.
//

import SwiftUI

struct LessonView: View {
    
    @State var lesson: LessonViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(lesson.disciplName).font(.headline)
            Text("\(lesson.dayTime) \(lesson.disciplType) в \(lesson.buildNum), \(lesson.audNum)")
        }
    }
}

struct LessonView_Previews: PreviewProvider {
    static var previews: some View {
        LessonView(lesson: .mock)
    }
}
