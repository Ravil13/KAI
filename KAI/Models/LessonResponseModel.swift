//
//  LessonResponseModel.swift
//  KAI
//
//  Created by Ravil Vildanov on 06.01.2020.
//  Copyright © 2020 Ravil Vildanov. All rights reserved.
//

import Foundation

struct LessonResponseModel: Decodable, Hashable {
    let dayDate: String
    let audNum: String
    let buildNum: String
    let dayTime: String
    let disciplType: String
    let disciplName: String
    let prepodName: String
    
    var disciplTypeNice: String {
        switch disciplType.trimmingCharacters(in: .whitespacesAndNewlines) {
        case "пр":
            return "Практика"
        case "лек":
            return "Лекция"
        case "конс":
            return "Консультация"
        case "л.р.":
            return "Лабораторная работа"
        default:
            return ""
        }
    }
    
    static let mock: LessonResponseModel = {
        let mock = LessonResponseModel(dayDate: "неч",
                                       audNum: "424",
                                       buildNum: "5",
                                       dayTime: "09:40",
                                       disciplType: "пр",
                                       disciplName: "Информационная безопасность",
                                       prepodName: "ТУМБИНСКАЯ МАРИНА ВЛАДИМИРОВНА")
        return mock
    }()
}
