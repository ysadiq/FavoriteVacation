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
import UIKit

class DestinationViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!

    lazy var viewModel: DestinationViewModel = {
        return DestinationViewModel()
    }()
    private var isPrivateSegment: Bool {
        segmentedControl.selectedSegmentIndex == 1
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        initViewModel()
    }

    func initView() {
        // config tableView
        tableView.estimatedRowHeight = 250
        tableView.rowHeight = UITableView.automaticDimension
    }

    func initViewModel() {
        viewModel.updateLoadingStatus = { [weak self] () in
            guard let self = self else {
                return
            }

            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }
                switch self.viewModel.state {
                case .empty, .error:
                    self.stopLoading()
                    UIView.animate(withDuration: 0.2, animations: {
                        self.tableView.alpha = 0.0
                    })
                case .loading:
                    self.startLoading()
                    UIView.animate(withDuration: 0.2, animations: {
                        self.tableView.alpha = 0.0
                    })
                case .populated:
                    self.stopLoading()
                    UIView.animate(withDuration: 0.2, animations: {
                        self.tableView.alpha = 1.0
                    })
                }
            }
        }

        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }

        viewModel.initFetch()
    }

    func startLoading() {
        let alert = UIAlertController(title: nil,
                                      message: "Please wait...",
                                      preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10,
                                                                     y: 5,
                                                                     width: 50,
                                                                     height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating()
        alert.view.addSubview(loadingIndicator)

        present(alert, animated: true, completion: nil)
    }

    func stopLoading() {
        dismiss(animated: false, completion: nil)
    }
}

extension DestinationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells(isPrivate: isPrivateSegment)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "destinationCell", for: indexPath) as? DestinationTableViewCell else {
            fatalError("Cell not exists in storyboard")
        }
        
        let cellViewModel = viewModel.getCellViewModel(at: indexPath, and: isPrivateSegment)
        cell.destinationCellViewModel = cellViewModel

        return cell
    }
}

extension DestinationViewController {
    @IBAction func sendButtonClicked(sender : AnyObject){
         let alertController = UIAlertController(title: "Send Location",
                                                 message: "",
                                                 preferredStyle: UIAlertController.Style.alert)

         alertController.addTextField { (textField : UITextField!) -> Void in
             textField.placeholder = "Enter Email"
         }
         let saveAction = UIAlertAction(title: "Send", style: UIAlertAction.Style.default, handler: nil)
         let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil)

         alertController.addAction(saveAction)
         alertController.addAction(cancelAction)

         self.present(alertController, animated: true, completion: nil)
     }

     @IBAction func segmentValueChanged(_ sender: Any) {
         tableView.reloadData()
     }
}
