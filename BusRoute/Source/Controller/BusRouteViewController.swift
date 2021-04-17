//
//  BusRouteViewController.swift
//  BusRoute
//
//  Created by Rathi on 3/31/21.
//

import UIKit
import RealmSwift

// MARK: Initialization
final class BusRouteViewController: UIViewController {
    
    @IBOutlet weak private var tableview: UITableView!
    
    var spinner = UIActivityIndicatorView()
    var presenter: BusRoutePresenterInput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doInitialSetUp()
    }
    
}
extension BusRouteViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        navigationController?.updateNavBarState(scrollView.contentOffset.y + scrollView.adjustedContentInset.top)
    }
}
private extension BusRouteViewController {
    
    func doInitialSetUp() {
        
        setUpTableView()
        setUpPresenter()
        setUpNavigatonBar()
        loadActivityIndicatorView()
    }
    
    func setUpTableView() {
        tableview.accessibilityIdentifier = "TableView"
        tableview.rowHeight = UITableView.automaticDimension
        tableview.estimatedRowHeight = 100
        tableview.registerNib(RouteDetailTableViewCell.self)
    }
    
    func setUpPresenter() {
        
        presenter = BusRoutePresenter(output: self)
        presenter?.getBusRouteList()
    }
    
    func setUpNavigatonBar() {
        
        navigationController?.setClearNavBar()
        navigationController?.updateAppearnaceToWhiteColor()
        navigationItem.title = ScreenTitle.route
        let rightbarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "bell_icon"), style: .plain, target: nil, action: nil)
        navigationItem.setRightBarButton(rightbarButton, animated: false)
    }
    
    func loadActivityIndicatorView() {
        
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
// MARK: - Storyboardable

extension BusRouteViewController: Storyboardable {
    
    class var storyboardName: String {
        return StoryBoardNameConstants.main
    }
}

extension BusRouteViewController: BusRoutePresenterOutput {
    func updateUIWithNoData() {
        tableview.reloadData()
        tableview.addNoContentBackgroundView(message: "No buses are available")
    }
    
    func showLoadingIndicator() {
        spinner.startAnimating()
    }
    
    func hideLoadingIndicator() {
        spinner.stopAnimating()
    }
    
    func showErrorDialog(with error: Error) {
        //TODO: error handling
        let toast = ToastView.toast(with: error.localizedDescription)
        toast?.show()
        print(error.localizedDescription)
    }
    
    func updateUI() {
        tableview.removeBackgroundView()
        tableview.reloadData()
    }
    
}
// MARK: Table view Datasource & Deelgates
extension BusRouteViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.getTripListCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(RouteDetailTableViewCell.self, indexPath: indexPath)
        if let detail = presenter?.getTripDetail(index: indexPath.row) {
            cell.configureCell(trip: detail)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
}
