//
//  Schedule.swift
//  KAI
//
//  Created by Ravil Vildanov on 03.01.2020.
//  Copyright © 2020 Ravil Vildanov. All rights reserved.
//

import Foundation

enum ScheduleType: String {
    case classes = "schedule"
    case exams = "examSchedule"
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
    
    static let mock: ScheduleResponseModel = {
        let mock = ScheduleResponseModel(monday: [LessonResponseModel.mock],
                                         tuesday: [LessonResponseModel.mock],
                                         wednesday: [LessonResponseModel.mock],
                                         thursday: [LessonResponseModel.mock],
                                         friday: [LessonResponseModel.mock],
                                         saturday: [LessonResponseModel.mock])
        return mock
    }()
}

struct DayScheduleViewModel: Hashable {
    let day: String
    let lessons: [LessonViewModel]
    
    static let mock = DayScheduleViewModel(day: "Понедельник", lessons: [.mock, .mock, .mock])
}

struct WeekScheduleViewModel {
    let scheduleResponseModel: ScheduleResponseModel
    
    let daySchedules: [DayScheduleViewModel]
    
    init(scheduleResponseModel: ScheduleResponseModel) {
        self.scheduleResponseModel = scheduleResponseModel
        
        let monday = DayScheduleViewModel(day: "Понедельник",
                                          lessons: scheduleResponseModel.monday.map { LessonViewModel(responseModel: $0) })
        let tuesday = DayScheduleViewModel(day: "Вторник",
                                           lessons: scheduleResponseModel.tuesday.map { LessonViewModel(responseModel: $0) })
        let wednesday = DayScheduleViewModel(day: "Среда",
                                             lessons: scheduleResponseModel.wednesday.map { LessonViewModel(responseModel: $0) })
        let thursday = DayScheduleViewModel(day: "Четверг",
                                            lessons: scheduleResponseModel.thursday.map { LessonViewModel(responseModel: $0) })
        let friday = DayScheduleViewModel(day: "Пятница",
                                          lessons: scheduleResponseModel.friday.map { LessonViewModel(responseModel: $0) })
        let saturday = DayScheduleViewModel(day: "Суббота",
                                            lessons: scheduleResponseModel.saturday.map { LessonViewModel(responseModel: $0) })
        
        self.daySchedules = [monday, tuesday, wednesday, thursday, friday, saturday]
    }
    
    static let mock = WeekScheduleViewModel(scheduleResponseModel: .mock)
}
