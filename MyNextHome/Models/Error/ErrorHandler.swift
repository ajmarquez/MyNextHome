//
//  ErrorHandler.swift
//  MyNextHome
//
//  Created by Abelardo Marquez on 02.07.21.
//

import Foundation

struct ErrorHandler {
    
    static let `default` = ErrorHandler()
    
    let genericMessage = "Oh, there's seems to be an error with that request"
    
    func presentError(_ error: LocalizedError){
        if let errorDescription = error.errorDescription {
            print(errorDescription)
        } else {
            print(genericMessage)
        }
    }
    
    private func presentToUser(message: String){
        print(message)
    }
}
