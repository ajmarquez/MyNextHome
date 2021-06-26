//
//  NetworkResponse.swift
//  MyNextHome
//
//  Created by Abelardo Marquez on 27.06.21.
//

import Foundation

struct NetworkResponse: Decodable {
    let resultCount: Int
    let items: [RealState]

    static let `default` = NetworkResponse(resultCount: 765432, items: [RealState.default])
}
