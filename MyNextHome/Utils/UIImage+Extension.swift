//
//  File.swift
//  MyNextHome
//
//  Created by Abelardo Marquez on 27.06.21.
//

import Foundation
import UIKit


extension UIImage {
    static func getRealStateImage(from url: String, completion: @escaping (UIImage?) -> Void) {

        let url = HomegateAPI.getImageURL(for: url)
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                print("realStateImage(from realState:) ->There was an error getting the Image")
            }
            guard let data = data else {
                print("realStateImage(from realState:) ->There was an error getting the Image")
                return
            }
            
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                completion(image)
            }
           
        }.resume()
    }
    
}
