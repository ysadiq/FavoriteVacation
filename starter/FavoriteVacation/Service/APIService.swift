//
//  Created by Yahya Saddiq on 3/19/20.
//  Copyright © 2020 Yahya Saddiq. All rights reserved.
//

import Foundation

class APIService: APIServiceProtocol {
  func fetchPopularDestinations(onCompletion: @escaping (_ destinations: [Destination]?, _ error: Error?)->()) {
    DispatchQueue.global().async {
      guard let path = Bundle.main.path(forResource: "content", ofType: "json") else {
        onCompletion(nil, nil)
        return
      }

      let data = try! Data(contentsOf: URL(fileURLWithPath: path))
      let decoder = JSONDecoder()
      decoder.dateDecodingStrategy = .iso8601
      let destinations = try! decoder.decode([Destination].self, from: data)

      // Simulate a waiting for fetching
      sleep(1)
      
      onCompletion(destinations, nil)
    }
  }
}
