//
//  ScheduleViewModel.swift
//  KAI_v2
//
//  Created by Ravil Vildanov on 07.01.2020.
//  Copyright © 2020 Ravil Vildanov. All rights reserved.
//

import SwiftUI
import Combine

class LessonViewModel: ObservableObject, Identifiable {
    
    // MARK: - Properties
    
    let id = UUID()
    
    @Published var dayDate: String
    @Published var audNum: String
    @Published var buildNum: String
    @Published var dayTime: String
    @Published var disciplType: String
    @Published var disciplTypeShort: String
    @Published var disciplName: String
    @Published var prepodName: String
    @Published var prepodEmoji: String
    
    private let responseModel: LessonResponseModel
    
    // MARK: - Initializers
    
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
}

class DayScheduleViewModel: ObservableObject, Identifiable {
    
    // MARK: - Properties
    
    let id = UUID()
    
    var day: WeekDay
    var lessons: [LessonViewModel]
    
    // MARK: - Initializers
    
    init(day: WeekDay, lessons: [LessonViewModel]) {
        self.day = day
        self.lessons = lessons
    }
}

enum WeekDay: String {
    case monday = "Понедельник"
    case tuesday = "Вторник"
    case wednesday = "Среда"
    case thursday = "Четверг"
    case friday = "Пятница"
    case saturday = "Суббота"
}

enum WeekType: Hashable {
    case even
    case odd
}

class ScheduleViewModel: ObservableObject {
    
    // MARK: - Properties
    
//    @Published var daySchedules: [DayScheduleViewModel] = []
    @Published var evenSchedules: [DayScheduleViewModel] = []
    @Published var oddSchedules: [DayScheduleViewModel] = []
    
    private var scheduleResponseModel: ScheduleResponseModel? {
        didSet {
            guard let responseModel = scheduleResponseModel else { return }
            let monday = DayScheduleViewModel(day: .monday,
                                              lessons: responseModel.monday.map { LessonViewModel(responseModel: $0)})
            let tuesday = DayScheduleViewModel(day: .tuesday,
                                               lessons: responseModel.tuesday.map { LessonViewModel(responseModel: $0)})
            let wednesday = DayScheduleViewModel(day: .wednesday,
                                                 lessons: responseModel.wednesday.map { LessonViewModel(responseModel: $0)})
            let thursday = DayScheduleViewModel(day: .thursday,
                                                lessons: responseModel.thursday.map { LessonViewModel(responseModel: $0)})
            let friday = DayScheduleViewModel(day: .friday,
                                              lessons: responseModel.friday.map { LessonViewModel(responseModel: $0)})
            let saturday = DayScheduleViewModel(day: .saturday,
                                                lessons: responseModel.saturday.map { LessonViewModel(responseModel: $0)})
            
            let daySchedules = [monday, tuesday, wednesday, thursday, friday, saturday]
            
            evenSchedules = daySchedules.map { schedule in DayScheduleViewModel(day: schedule.day, lessons: schedule.lessons.filter { $0.dayDate != "неч" })}
            oddSchedules = daySchedules.map { schedule in DayScheduleViewModel(day: schedule.day, lessons: schedule.lessons.filter { $0.dayDate != "чет" })}
            
        }
    }
    
    private let scheduleService: ScheduleService
    
    // MARK: - Initializers
    
    init(scheduleService: ScheduleService = ScheduleServiceDefault()) {
        self.scheduleService = scheduleService
        self.loadSchedule(for: "4435")
    }
    
    func loadSchedule(for groupNumber: String) {
        scheduleService.requestGroupId(groupNumber: groupNumber, success: { [weak self] groupIdResponseModel in
            guard let gruopId = groupIdResponseModel.first?.id else { return }
            self?.scheduleService.requestSchedule(for: String(gruopId), success: { scheduleResponseModel in
                self?.scheduleResponseModel = scheduleResponseModel
            }, failure: { error in })
            }, failure: { error in })
    }
}
