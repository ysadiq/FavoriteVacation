/// Copyright (c) 2020 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import Foundation

class DestinationViewModel {

    let apiService: APIServiceProtocol

    private var destinations: [Destination] = [Destination]()

    private var publicCellViewModels: [DestinationCellViewModel] = [DestinationCellViewModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    private var privateCellViewModels: [DestinationCellViewModel] = [DestinationCellViewModel]()

    // callback for interfaces
    var state: State = .empty {
        didSet {
            self.updateLoadingStatus?()
        }
    }

    var reloadTableViewClosure: (()->())?
    var updateLoadingStatus: (()->())?

    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }

    func initFetch() {
        state = .loading
        apiService.fetchPopularDestinations { [weak self] (destinations, error) in
            guard let self = self else {
                return
            }

            guard error == nil,
                let destinations = destinations else {
                return
            }

            self.processFetchedDestination(destinations: destinations)
            self.state = .populated
        }
    }

    func getCellViewModel(at indexPath: IndexPath, and isPrivate: Bool) -> DestinationCellViewModel {
        if isPrivate {
            return privateCellViewModels[indexPath.row]
        } else {
            return publicCellViewModels[indexPath.row]
        }
    }

    func createCellViewModel(destination: Destination) -> DestinationCellViewModel {
        return DestinationCellViewModel(titleText: destination.name,
                                        locationText: destination.location,
                                        imageName: destination.imageName,
                                        price: destination.price)
    }

    private func processFetchedDestination(destinations: [Destination]) {
        var privateVMS = [DestinationCellViewModel]()
        var publicVMS = [DestinationCellViewModel]()
        for destination in destinations {
            if destination.isPrivate {
                privateVMS.append(createCellViewModel(destination: destination))
            } else {
                publicVMS.append(createCellViewModel(destination: destination))
            }
        }
        publicCellViewModels = publicVMS
        privateCellViewModels = privateVMS
    }

    func numberOfCells(isPrivate: Bool) -> Int {
        return isPrivate ? privateCellViewModels.count : publicCellViewModels.count
    }

}
