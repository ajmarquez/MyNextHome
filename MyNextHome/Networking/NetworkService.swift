//
//  NetworkService.swift
//  MyNextHome
//
//  Created by Abelardo Marquez on 26.06.21.
//

import Foundation
import Combine


extension URLSession {
    func publisher<T: Decodable>(for url: URL,
                                 responseType: T.Type = T.self,
                                 decoder: JSONDecoder = .init()
    ) -> AnyPublisher<T,Error> {
        dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: T.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}
