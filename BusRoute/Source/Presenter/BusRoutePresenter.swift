//
//  BusRoutePresenter.swift
//  BusRoute
//
//  Created by Rathi on 4/3/21.
//

import UIKit
import RealmSwift
protocol BusRoutePresenterInput: class {
    func getBusRouteList()
    func getTripListCount() -> Int
    func getTripDetail(index: Int) -> Trip?
}

protocol BusRoutePresenterOutput: class {
    func updateUI()
    func updateUIWithNoData()
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func showErrorDialog(with error: Error)
}

final class BusRoutePresenter: NSObject {
    
    weak var presenterOutput: BusRoutePresenterOutput?
    private var currentAPIRequest: APIService?
    private var tripList: [Trip]?
    var timer: Timer?
    
    init(output: BusRoutePresenterOutput) {
        presenterOutput = output
    }
}

extension BusRoutePresenter: BusRoutePresenterInput {
    
    func cancelCurrentRequest() {
        currentAPIRequest?.cancelRequest()
        currentAPIRequest = nil
    }
    
    func getTripListCount() -> Int {
        tripList?.count ?? 0
    }
    
    func getTripDetail(index: Int) -> Trip? {
        tripList?.at(index: index)
    }
    
    private func startTimeInterval() {
        invalidateTimer()
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(60), target: self, selector: #selector(timerFired(timer:)), userInfo: nil, repeats: false)
    }
    
    @objc func timerFired(timer: Timer) {
        self.presenterOutput?.showLoadingIndicator()
        let database = try! Realm()
        let result = database.objects(Trip.self)
        self.tripList = Array(result.filter {$0.getDepartsInMinutes() > 0}).sorted(by: {$0.tripStartTime < $1.tripStartTime})
        if self.tripList?.count ?? 0 > 0 {
            self.presenterOutput?.updateUI()
        } else {
            self.presenterOutput?.updateUIWithNoData()
        }
        self.presenterOutput?.hideLoadingIndicator()
        self.startTimeInterval()
    }
    
    private func invalidateTimer() {
        self.timer?.invalidate()
        self.timer = nil
    }
    
    func getBusRouteList() {
        cancelCurrentRequest()
        presenterOutput?.showLoadingIndicator()
        currentAPIRequest = APIService().getBusRoute(completion: { [weak self] (response, error) in
            guard let self = self else { return }
            self.presenterOutput?.hideLoadingIndicator()
            if let error = error {
                self.presenterOutput?.showErrorDialog(with: error)
            } else {
                
                let items = response?.routeTimings.flatMap{$0}
                items?.forEach({ (trip) in
                    trip.route = response?.routeInfo.first(where: {$0.id == trip.tripID})
                })
                let realm = try! Realm()
                try! realm.write() {
                    if let timings = items {
                        realm.add(timings, update: .modified)
                    }
                }
                //Remove the trip which is already Departed
                self.tripList = items?.filter({$0.getDepartsInMinutes() > 0}).sorted(by: {$0.tripStartTime < $1.tripStartTime})
                if self.tripList?.count ?? 0 > 0 {
                    self.presenterOutput?.updateUI()
                } else {
                    self.presenterOutput?.updateUIWithNoData()
                }
                self.startTimeInterval()
            }
        })
    }
}
