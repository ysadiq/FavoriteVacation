//
//  Created by Yahya Saddiq on 3/19/20.
//  Copyright © 2020 Yahya Saddiq. All rights reserved.
//

protocol APIServiceProtocol {
  func fetchPopularDestinations(onCompletion: @escaping (_ destinations: [Destination]?, _ error: Error?)->())
}
