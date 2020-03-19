//
//  Schedule.swift
//  KAI_v2
//
//  Created by Ravil Vildanov on 07.01.2020.
//  Copyright © 2020 Ravil Vildanov. All rights reserved.
//

import Foundation

enum ScheduleType: String {
    case classes = "schedule"
    case exams = "examSchedule"
}

struct LessonResponseModel: Decodable, Hashable {
    let dayDate: String
    let audNum: String
    let buildNum: String
    let dayTime: String
    let disciplType: String
    let disciplName: String
    let prepodName: String
}

struct GroupIdResponseModel: Decodable {
    let id: Int
}

struct ScheduleResponseModel: Decodable {
    let monday: [LessonResponseModel]
    let tuesday: [LessonResponseModel]
    let wednesday: [LessonResponseModel]
    let thursday: [LessonResponseModel]
    let friday: [LessonResponseModel]
    let saturday: [LessonResponseModel]
    
    enum CodingKeys: String, CodingKey {
        case monday = "1"
        case tuesday = "2"
        case wednesday = "3"
        case thursday = "4"
        case friday = "5"
        case saturday = "6"
    }
}
