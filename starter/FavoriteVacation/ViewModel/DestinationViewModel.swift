//
//  Created by Yahya Saddiq on 3/19/20.
//  Copyright © 2020 Yahya Saddiq. All rights reserved.
//

import Foundation

class DestinationViewModel {
  let apiService: APIServiceProtocol?

  var publicCellViewModels: [DestinationCellViewModel]?
  var privateCellViewModels: [DestinationCellViewModel]?

  var reloadTableViewClosure: (()->())?
  var updateLoadingStatus: (()->())?

  var state: State = .empty {
    didSet {
      updateLoadingStatus?()
      if state == .populated {
        reloadTableViewClosure?()
      }
    }
  }
  
  init(apiService: APIServiceProtocol = APIService()) {
    self.apiService = apiService
  }
  
  func initFetch() {
    state = .loading
    apiService?.fetchPopularDestinations { [weak self] (destinations, error) in
      guard let self = self else {
        return
      }
      
      guard error == nil,
        let destinations = destinations else {
          return
      }
      
      self.processFetched(destinations: destinations)
      self.state = .populated
    }
  }

  func processFetched(destinations: [Destination]) {
    var privateViewModels = [DestinationCellViewModel]()
    var publicViewModels = [DestinationCellViewModel]()

    for destination in destinations {
      if let isPrivate = destination.isPrivate, isPrivate {
        privateViewModels.append(createCellViewModel(destination: destination))
      } else {
        publicViewModels.append(createCellViewModel(destination: destination))
      }
    }

    publicCellViewModels = publicViewModels
    privateCellViewModels = privateViewModels
  }

  func createCellViewModel(destination: Destination) -> DestinationCellViewModel {
    return DestinationCellViewModel(titleText: destination.name,
                                    locationText: destination.location,
                                    imageName: destination.imageName,
                                    price: destination.price,
                                    isFavorite: destination.isFavorite,
                                    credit: destination.credit)
  }
  
  func getCellViewModel(at indexPath: IndexPath, and isPrivate: Bool) -> DestinationCellViewModel? {
    if isPrivate {
      return privateCellViewModels?[indexPath.row]
    } else {
      return publicCellViewModels?[indexPath.row]
    }
  }
  
  func numberOfCells(isPrivate: Bool) -> Int? {
    return isPrivate ? privateCellViewModels?.count : publicCellViewModels?.count
  }
}
