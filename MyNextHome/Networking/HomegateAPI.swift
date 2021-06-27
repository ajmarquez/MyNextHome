//
//  HomegateAPI.swift
//  MyNextHome
//
//  Created by Abelardo Marquez on 26.06.21.
//

import Foundation
import Combine

class HomegateAPI {
    var urlSession = URLSession.shared
    
    func loadRealStates() -> AnyPublisher<RealStateResponse, Error> {
        urlSession.publisher(for: Endpoint.realStateList.url)
    }

}
