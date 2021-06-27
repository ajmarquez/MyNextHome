//
//  NetworkResponse.swift
//  MyNextHome
//
//  Created by Abelardo Marquez on 27.06.21.
//

import Foundation

struct NetworkResponse<Wrapped: Decodable>: Decodable {
    let items: Wrapped
}

struct RealStateResponse: Decodable {
   let items: [RealState]
    
    static let `default` = RealStateResponse(items: [RealState.default])
}


