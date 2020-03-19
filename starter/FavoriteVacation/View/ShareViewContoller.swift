//
//  Created by Yahya Saddiq on 3/19/20.
//  Copyright © 2020 Yahya Saddiq. All rights reserved.
//

import UIKit

class ShareViewController: UIViewController {
  @IBOutlet weak var sendButton: UIButton!
  @IBOutlet weak var cancelButton: UIButton!
  @IBOutlet weak var emailTextField: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()

    addBorder(to: sendButton)
    addBorder(to: cancelButton)
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    
    configureEmailTextField()
    configureButtons()
  }

  // MARK: UI Elements Configuration
  func configureEmailTextField() {
    let color = UIColor.lightGray
    
    emailTextField.layer.borderWidth = 1.0
    emailTextField.layer.cornerRadius = 4.0
    emailTextField.layer.borderColor = color.cgColor
    emailTextField.attributedPlaceholder = NSAttributedString(string: "Enter your partner's email",
                                                              attributes: [NSAttributedString.Key.foregroundColor: color])
  }
  
  func configureButtons() {
    let cgColor = UIColor.black.cgColor
    
    sendButton.layer.borderColor = cgColor
    cancelButton.layer.borderColor = cgColor
  }
  
  func addBorder(to button: UIButton) {
    button.layer.borderWidth = 1.0
    button.layer.cornerRadius = 8.0
  }
}

// MARK: - User Interface Actions
extension ShareViewController {
  @IBAction func sendButtonPressed(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func cancelButtonPressed(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
}
