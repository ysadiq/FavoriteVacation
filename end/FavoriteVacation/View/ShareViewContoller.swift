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
  
  func configureEmailTextField() {
    let resolvedColor = UIColor.placeholderText.resolvedColor(with: traitCollection)
    
    emailTextField.layer.borderWidth = 1.0
    emailTextField.layer.cornerRadius = 4.0
    emailTextField.layer.borderColor = resolvedColor.cgColor
    emailTextField.attributedPlaceholder = NSAttributedString(string: "Enter your partner's email",
                                                              attributes: [NSAttributedString.Key.foregroundColor: resolvedColor])
  }

  // MARK: UI Elements Configuration
  func configureButtons() {
    let resolvedColor = UIColor.label.resolvedColor(with: traitCollection)
    
    sendButton.layer.borderColor = resolvedColor.cgColor
    cancelButton.layer.borderColor = resolvedColor.cgColor
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
