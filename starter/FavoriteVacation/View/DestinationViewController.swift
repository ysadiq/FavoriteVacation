//
//  Created by Yahya Saddiq on 3/19/20.
//  Copyright © 2020 Yahya Saddiq. All rights reserved.
//

import UIKit

class DestinationViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var segmentedControl: UISegmentedControl!

  var isPrivateSegment: Bool {
    segmentedControl.selectedSegmentIndex == 1
  }

  lazy var viewModel: DestinationViewModel = {
    return DestinationViewModel()
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureTableView()
    initViewModel()
  }

  // MARK: ViewModel Initialization
  func initViewModel() {
    initLoadingStatusClosure()
    initReloadTableClosure()

    viewModel.initFetch()
  }

  func initLoadingStatusClosure() {
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
           self.hideTableView()
         case .loading:
           self.startLoading()
           self.hideTableView()
         case .populated:
           self.stopLoading()
           self.showTableView()
         }
       }
     }
  }

  func initReloadTableClosure() {
    viewModel.reloadTableViewClosure = { [weak self] () in
       DispatchQueue.main.async {
         self?.tableView.reloadData()
       }
     }
  }

  // MARK: TableView configuration
  func configureTableView() {
    tableView.estimatedRowHeight = 250
    tableView.rowHeight = UITableView.automaticDimension
  }

  func showTableView() {
    UIView.animate(withDuration: 0.2, animations: {
      self.tableView.alpha = 1.0
    })
  }

  func hideTableView() {
    UIView.animate(withDuration: 0.2, animations: {
      self.tableView.alpha = 0.0
    })
  }

  // MARK: Loading Alert Configuration
  func startLoading() {
    let alert = UIAlertController(title: nil,
                                  message: "Please wait...",
                                  preferredStyle: .alert)
    
    let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
    loadingIndicator.hidesWhenStopped = true
    loadingIndicator.style = .medium
    loadingIndicator.startAnimating()

    alert.view.addSubview(loadingIndicator)
    present(alert, animated: true, completion: nil)
  }
  
  func stopLoading() {
    dismiss(animated: false, completion: nil)
  }
}

// MARK: - UITableViewDataSource
extension DestinationViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let numberOfCells = viewModel.numberOfCells(isPrivate: isPrivateSegment) else {
      return 0
    }
    
    return numberOfCells
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "destinationCell",
                                                   for: indexPath) as? DestinationTableViewCell else {
                                                    fatalError("Cell not exists in storyboard")
    }
    
    let cellViewModel = viewModel.getCellViewModel(at: indexPath, and: isPrivateSegment)
    cell.destinationCellViewModel = cellViewModel
    
    return cell
  }
}

// MARK: - User Interface Actions
extension DestinationViewController {
  @IBAction func segmentValueChanged(_ sender: Any) {
    tableView.reloadData()
  }
}
