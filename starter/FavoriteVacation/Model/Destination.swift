//
//  Created by Yahya Saddiq on 3/19/20.
//  Copyright © 2020 Yahya Saddiq. All rights reserved.
//

struct Destinations: Codable {
  let destinations: [Destination]
}

struct Destination: Codable {
  let name: String?
  let location: String?
  let credit: String?
  let price: Int?
  let imageName: String?
  let isPrivate: Bool?
  let isFavorite: Bool?
}
