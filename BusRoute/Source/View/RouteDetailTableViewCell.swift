//
//  RouteDetailTableViewCell.swift
//  BusRoute
//
//  Created by Rathi on 4/2/21.
//

import UIKit

final class RouteDetailTableViewCell: UITableViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var sourceTimeLabel: UILabel!
    @IBOutlet weak var destinationTimeLabel: UILabel!
    @IBOutlet weak var departureInTimingLabel: UILabel!
    @IBOutlet weak var travelTimeLabel: UILabel!
    @IBOutlet weak var availableSeatLabel: UILabel!
    @IBOutlet weak var totalSeatLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.setShadow(radius: 10)
    }
    
    func configureCell(trip: Trip) {
        let routeInfo = trip.route
        sourceLabel.text = routeInfo?.source
        destinationLabel.text = routeInfo?.destination
        destinationLabel.text = routeInfo?.destination
        availableSeatLabel.text = String(format: UIStrings.availableSeat, trip.avaiable)
        totalSeatLabel.text = String(format: UIStrings.totalSeat, trip.totalSeats)
        sourceTimeLabel.text = trip.getFormattedStartDate()
        destinationTimeLabel.text = trip.getFormattedEndDate()
        travelTimeLabel.text = String(format: UIStrings.travelTime, routeInfo?.getTripDuration() ?? 0)
        
        let formattedText = NSMutableAttributedString().bold(trip.getDepartsInMinutes().stringValue, size: 25, color: .black).normal(UIStrings.minute, size: 14, color: .black)
        departureInTimingLabel.attributedText = formattedText
    }
}
