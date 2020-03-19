//
//  Created by Yahya Saddiq on 3/19/20.
//  Copyright © 2020 Yahya Saddiq. All rights reserved.
//

import UIKit

extension UIColor {
  public static var location: UIColor = {
    return UIColor { (trait) -> UIColor in
      if trait.userInterfaceStyle == .dark {
        return .red
      } else {
        return .lightGray
      }
    }
  }()
}
