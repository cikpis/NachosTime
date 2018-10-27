//
//  WebServiceRequest.swift
//  PopcornTime
//
//  Created by Carmelo Gallo on 28/09/2018.
//  Copyright © 2018 Carmelo Gallo. All rights reserved.
//

struct WebServiceRequest {
    
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case patch = "PATCH"
        case delete = "DELETE"
    }
    
    enum Encoding {
        case urlEncoded
        case json
    }
    
    var method: HTTPMethod
    var url: String
    var headers: [String: String]?
    var params: [String: Any]?
    var paramsEncoding: Encoding
    
}