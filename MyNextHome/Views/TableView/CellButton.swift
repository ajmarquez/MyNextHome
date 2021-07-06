//
//  FavoriteButton.swift
//  MyNextHome
//
//  Created by Abelardo Marquez on 30.06.21.
//

import Foundation
import UIKit

class CellButton: UIButton {
    
    typealias DidTapButton = (CellButton) -> ()
    var favState: Bool = false  {
        didSet{
            configImageState()
        }
    }


    func configImageState() {
        if favState {
            self.setImage(UIImage(named: Constants.Images.heartFull), for: .normal)
        } else {
            self.setImage(UIImage(named: Constants.Images.heartEmpty), for: .normal)
        }
    }
    
}
