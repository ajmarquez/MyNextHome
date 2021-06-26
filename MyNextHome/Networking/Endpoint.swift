//
//  Endpoint.swift
//  MyNextHome
//
//  Created by Abelardo Marquez on 26.06.21.
//

import Foundation

struct Endpoint {
    var path: String
    var query: [URLQueryItem] = []
}

extension Endpoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "private-492e5-homegate1.apiary-mock.com"
        components.path = "/" + path
        
        guard let url = components.url else {
            preconditionFailure(
            "Invalid URL Components: \(components)"
            )
        }
        print(url)
        return url
    }
}


extension Endpoint {    
    static var realStateList: Self {
        Endpoint(path: "properties")
    }
}
