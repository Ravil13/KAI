//
//  ScheduleService.swift
//  KAI_v2
//
//  Created by Ravil Vildanov on 07.01.2020.
//  Copyright © 2020 Ravil Vildanov. All rights reserved.
//

import Foundation

enum ScheduleEndpoint: Endpoint {
    
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
        
        let endpoint = ScheduleEndpoint.groupId(groupNumber: groupNumber)
        API.request(endpoint: endpoint, success: success, failure: failure)
    }
    
    func requestSchedule(for groupId: String,
                                success: @escaping (ScheduleResponseModel) -> Void,
                                failure: @escaping ErrorClouser) {
        
        let endpoint = ScheduleEndpoint.schedule(scheduleType: .classes, groupId: groupId)
        API.request(endpoint: endpoint, success: success, failure: failure)
    }
}
