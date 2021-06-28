//
//  RealStateViewModel.swift
//  MyNextHome
//
//  Created by Abelardo Marquez on 28.06.21.
//

import Foundation
import Combine

final class RealStateViewModel: ListViewModel {
    var networkService: HomegateAPI
    @Published private(set) var array: [RealState] = [] {
        didSet {
            print("Array was set")
            print(array)
        }
    }
    
    init(with networkService: HomegateAPI) {
        self.networkService = networkService
        self.fetchList()
        print("HOLA")
    }
    
    
    
    func fetchList(){
        networkService.loadRealStates()
            .replaceError(with: RealStateResponse.default)
            .map(\.items)
            .assign(to: &$array)
    }
    
    func getRealStateList() {
    }
    
    
    
    func didFavoriteRealState() {}
    
    func getHeightofRows() -> Int {
        return 300
    }
    
}
