//
//  ScheduleService.swift
//  KAI
//
//  Created by Ravil Vildanov on 03.01.2020.
//  Copyright © 2020 Ravil Vildanov. All rights reserved.
//

import Foundation

enum ScheduleEndPoint: EndPoint {
    
    case groupId(groupNumber: String)
    case schedule(scheduleType: ScheduleType, groupId: String)
    
    var urlComponents: URLComponents? {
        switch self {
        case .groupId, .schedule:
            return URLComponents(string: "https://kai.ru/raspisanie")
        }
    }
    
    var parameters: [String: String]? {
        switch self {
        case .groupId(let groupNumber):
            return ["p_p_id": "pubStudentSchedule_WAR_publicStudentSchedule10",
                    "p_p_lifecycle": "2",
                    "p_p_resource_id": "getGroupsURL",
                    "query": groupNumber]
        case .schedule(let scheduleType, let groupId):
            return ["p_p_id": "pubStudentSchedule_WAR_publicStudentSchedule10",
                    "p_p_lifecycle": "2",
                    "p_p_resource_id": scheduleType.rawValue,
                    "p_p_col_count": "1",
                    "groupId": groupId]
        }
    }
}

protocol ScheduleService {
    func requestGroupId(groupNumber: String,
                               success: @escaping ([GroupIdResponseModel]) -> Void,
                               failure: @escaping ErrorClouser)
    
    func requestSchedule(for groupId: String,
                                success: @escaping (ScheduleResponseModel) -> Void,
                                failure: @escaping ErrorClouser)
}

class ScheduleServiceDefault: ScheduleService {
    
    func requestGroupId(groupNumber: String,
                               success: @escaping ([GroupIdResponseModel]) -> Void,
                               failure: @escaping ErrorClouser) {
        
        let endPoint = ScheduleEndPoint.groupId(groupNumber: groupNumber)
        API.request(endpoint: endPoint, success: success, failure: failure)
    }
    
    func requestSchedule(for groupId: String,
                                success: @escaping (ScheduleResponseModel) -> Void,
                                failure: @escaping ErrorClouser) {
        
        let endPoint = ScheduleEndPoint.schedule(scheduleType: .classes, groupId: groupId)
        API.request(endpoint: endPoint, success: success, failure: failure)
    }
}
