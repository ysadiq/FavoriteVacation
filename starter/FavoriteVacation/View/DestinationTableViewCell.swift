//
//  Created by Yahya Saddiq on 3/19/20.
//  Copyright © 2020 Yahya Saddiq. All rights reserved.
//

import UIKit

class DestinationTableViewCell: UITableViewCell {
  @IBOutlet weak var mainImageView: UIImageView!
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var locationLabel: UILabel!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var creditLabel: UILabel!
  @IBOutlet weak var sendButton: UIButton!
  @IBOutlet weak var isFavoriteImageView: UIImageView!
  
  var destinationCellViewModel: DestinationCellViewModel? {
    didSet {
      titleLabel.text = destinationCellViewModel?.titleText
      locationLabel.text = destinationCellViewModel?.locationText
      // TODO: Add more code here...
      
      if let imageName = destinationCellViewModel?.imageName {
        mainImageView?.image = UIImage(named: imageName)
      }
      
      if let price = destinationCellViewModel?.price {
        priceLabel.text = "$\(price)"
      }
      
      if let isFavorite = destinationCellViewModel?.isFavorite {
        // TODO: Replace the below line with SF Symbols
        isFavoriteImageView.image = UIImage(named: isFavorite ? "filledHeart" : "heart")
      }
      
      if let credit = destinationCellViewModel?.credit {
        creditLabel.text = "Photo by \(credit)"
      }
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    sendButton.layer.borderWidth = 1.0
    sendButton.layer.cornerRadius = 8.0
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    sendButton.layer.borderColor = UIColor.black.cgColor
  }
}
