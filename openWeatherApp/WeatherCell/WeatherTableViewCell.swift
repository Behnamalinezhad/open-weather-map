//
//  WeatherTableViewCell.swift
//  MyWeather
//
//  Created by Afraz Siddiqui on 3/25/20.
//  Copyright © 2020 ASN GROUP LLC. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var highTempLabel: UILabel!
    @IBOutlet var lowTempLabel: UILabel!
    @IBOutlet var iconImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    static let identifier = "WeatherTableViewCell"

    static func nib() -> UINib {
        return UINib(nibName: "WeatherTableViewCell",
                     bundle: nil)
    }

    func configure(with model: DailyWeather?) {
        self.highTempLabel.textAlignment = .center
        self.lowTempLabel.textAlignment = .center
        self.lowTempLabel.text = "\(Int((model?.temp?.min ?? 0.0) - 273.15))°c"
        self.highTempLabel.text = "\(Int((model?.temp?.max ?? 0.0) - 273.15))°c"
        self.dayLabel.text = getDayForDate(Date(timeIntervalSince1970: Double(model?.dt ?? 1)))
        self.iconImageView.contentMode = .scaleAspectFit

        if let icon = model?.weather?[0].main?.lowercased() {
            if icon.contains("clear") {
                self.iconImageView.image = UIImage(named: "clear")
            } else if icon.contains("rain") {
                self.iconImageView.image = UIImage(named: "rain")
            } else {
                self.iconImageView.image = UIImage(named: "clouds")
            }
        }
    }

    func getDayForDate(_ date: Date?) -> String {
        guard let inputDate = date else {
            return ""
        }

        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: inputDate)
    }
    
}
