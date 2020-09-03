//
//  ResourceType.swift
//  DigitasWorld
//
//  Created by ashok on 02/09/20.
//  Copyright © 2020 eSoft Technologies. All rights reserved.
//

import Foundation
import Moya

enum ResourceType {
    case all
}

extension ResourceType: TargetType {
    
    var baseURL: URL {
        return URL(string:Configuration.baseURL)!
    }
    
    var path: String {
        switch self {
        case .all:
            return "all"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .all:
            return Moya.Method.get
        }
    }
    
    var task: Task {
        switch self {
        case .all:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .all:
            return [Constant.kApiHeaderKey:Configuration.apiKey, Constant.kHostHeaderKey:Configuration.apiHost]
        }
    }
    
    var sampleData: Data {
          return Data()
    }
}
