//
//  DetailLessonView.swift
//  KAI
//
//  Created by Ravil Vildanov on 06.01.2020.
//  Copyright © 2020 Ravil Vildanov. All rights reserved.
//

import SwiftUI

struct DetailLessonView: View {
    
    @State var lesson: LessonViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(lesson.disciplName).font(.headline)
            Text(lesson.disciplType).foregroundColor(.gray)
            if !lesson.prepodName.isEmpty {
                Text("\(lesson.prepodEmoji) \(lesson.prepodName)")
            }
            Text("🏫 \(lesson.buildNum), \(lesson.audNum)")
            Text("⏰ \(lesson.dayTime)")
        }
    }
}

struct DetailLessonView_Previews: PreviewProvider {
    static var previews: some View {
        DetailLessonView(lesson: .mock)
    }
}
