//
//  LessonViewModel.swift
//  KAI
//
//  Created by Ravil Vildanov on 06.01.2020.
//  Copyright © 2020 Ravil Vildanov. All rights reserved.
//

import Foundation

struct LessonViewModel: Hashable {
    let responseModel: LessonResponseModel
    
    let dayDate: String
    let audNum: String
    let buildNum: String
    let dayTime: String
    let disciplType: String
    let disciplTypeShort: String
    let disciplName: String
    let prepodName: String
    let prepodEmoji: String
    
    init(responseModel: LessonResponseModel) {
        self.responseModel = responseModel
        
        self.dayDate = responseModel.dayDate.trimmingCharacters(in: .whitespacesAndNewlines)
        self.audNum = responseModel.audNum.trimmingCharacters(in: .whitespacesAndNewlines)
        self.buildNum = responseModel.buildNum.trimmingCharacters(in: .whitespacesAndNewlines)
        self.dayTime = responseModel.dayTime.trimmingCharacters(in: .whitespacesAndNewlines)
        self.disciplTypeShort = responseModel.disciplType.trimmingCharacters(in: .whitespacesAndNewlines)
        self.disciplName = responseModel.disciplName.trimmingCharacters(in: .whitespacesAndNewlines)
        let prepodName = responseModel.prepodName.trimmingCharacters(in: .whitespacesAndNewlines).capitalized
        self.prepodName = prepodName
        
        switch responseModel.disciplType.trimmingCharacters(in: .whitespacesAndNewlines) {
        case "пр":
            self.disciplType = "Практика"
        case "лек":
            self.disciplType = "Лекция"
        case "конс":
            self.disciplType = "Консультация"
        case "л.р.":
            self.disciplType = "Лабораторная работа"
        default:
            self.disciplType = ""
        }
        
        self.prepodEmoji = prepodName.last ?? Character("_") == "а" ? "👩‍🏫" : "👨‍🏫"
    }
    
    static let mock = LessonViewModel(responseModel: .mock)
}
