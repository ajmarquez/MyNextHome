//
//  RealStateViewModel.swift
//  MyNextHome
//
//  Created by Abelardo Marquez on 28.06.21.
//

import Foundation
import Combine

final class RealStateViewModel {
    typealias RealStateList = [RealState]
    var networkService: HomegateAPI
    @Published private(set) var array: [RealState] = []
    
    
    init(with networkService: HomegateAPI) {
        self.networkService = networkService
        self.fetchList()
    }
    
    
    private func fetchList(){
        networkService.loadRealStates()
            .replaceError(with: RealStateResponse.default)
            .map(\.items)
            .assign(to: &$array)
    }
    
    func addItemToFavorites(_ item: RealState) {
        FavoritesRepository().createData(realState: item)
    }
    
    func removeItemFromFavorites(_ item: RealState) {
        print("Delete ")
        FavoritesRepository().deleteEntity(for: item.title)
    }
    
}
