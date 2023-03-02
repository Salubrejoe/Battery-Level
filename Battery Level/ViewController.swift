//
//  ViewController.swift
//  Battery Level
//
//  Created by Lore P on 02/03/2023.
//

import UIKit

class ViewController: UIViewController {
  enum BatteryState {
    case isCharging
    case notCharging
  }
  
  var battery100Image = UIImage(systemName: "battery.100")!.withTintColor(.black, renderingMode: .alwaysOriginal)
  var battery75Image = UIImage(systemName: "battery.75")!.withTintColor(.black, renderingMode: .alwaysOriginal)
  var battery50Image = UIImage(systemName: "battery.50")!.withTintColor(.black, renderingMode: .alwaysOriginal)
  var battery25Image = UIImage(systemName: "battery.25")!.withTintColor(.black, renderingMode: .alwaysOriginal)
  var battery0Image = UIImage(systemName: "battery.0")!.withTintColor(.black, renderingMode: .alwaysOriginal)

  
  let dagger = UIDevice.current
  
  var state: BatteryState!
  
  private var batteryImageView: UIImageView = {
    
    let view = UIImageView()
    view.image = UIImage(systemName: "battery.100")
    view.contentMode = .scaleAspectFit
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private var batteryLevelLabel: UILabel = {
    
    let label = UILabel()
    label.font = .systemFont(ofSize: 35, weight: .semibold)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .center
    return label
  }()
  private var batteryStatusLabel: UILabel = {
    
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 15)
    label.textAlignment = .center
    return label
  }()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Battery level"
    view.backgroundColor = .systemBackground
    
    configureUI()
    
    getBatteryLevel()
  }
  
  private func getBatteryLevel() {
    dagger.isBatteryMonitoringEnabled = true
    
    batteryImageView.tintColor = {
      switch state {
      case .isCharging:
        return .systemYellow
      case .notCharging:
        return .systemGreen
      case .none:
        return .systemRed
      }
    }()
    
    let currentCharge = dagger.batteryLevel
    let chargeStatus = dagger.batteryState
    
    // Set correct Image
    if currentCharge >= 0.87 {
      batteryImageView.image = battery100Image
    } else if currentCharge < 0.87 && currentCharge >= 0.75 {
      batteryImageView.image = battery75Image
    } else if currentCharge < 0.75 && currentCharge >= 0.50 {
      batteryImageView.image = battery50Image
    } else if currentCharge < 0.50 && currentCharge >= 0.25 {
      batteryImageView.image = battery25Image
    } else if currentCharge < 0.25 {
      batteryImageView.image = battery0Image
    }
    
    // Set up Percentage Label
    let chargeFormatted = (currentCharge*100).formatted()
    batteryLevelLabel.text = "\(chargeFormatted)%"
    
    
    // Set up status Label
    switch chargeStatus {
    case .charging:
      batteryStatusLabel.text = "Charging"
      batteryImageView.tintColor = .systemYellow
      state = .isCharging
    case .unknown:
      batteryImageView.image = UIImage(systemName: "xmark.octagon.fill")
      batteryLevelLabel.text = "Unknown"
      batteryStatusLabel.text = ""
    case .full:
      batteryLevelLabel.text = "100%"
      batteryStatusLabel.text = "Fully charged!"
      state = .notCharging
    default:
      batteryStatusLabel.text = ""
      state = .notCharging
    }
  }
  
  
  
  
}

extension ViewController {
  
  private func configureUI() {
    
    view.addSubview(batteryImageView)
    view.addSubview(batteryLevelLabel)
    view.addSubview(batteryStatusLabel)
    
    let imageViewConstraints = [
      batteryImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -90),
      batteryImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      batteryImageView.heightAnchor.constraint(equalToConstant: 150),
      batteryImageView.widthAnchor.constraint(equalToConstant: 200)
    ]
    
    let levelLabelConstraints = [
      batteryLevelLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      batteryLevelLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      batteryLevelLabel.heightAnchor.constraint(equalToConstant: 50),
      batteryLevelLabel.widthAnchor.constraint(equalToConstant: 200)
    ]
    
    let statusLabelConstraints = [
      batteryStatusLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 30),
      batteryStatusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      batteryStatusLabel.heightAnchor.constraint(equalToConstant: 50),
      batteryStatusLabel.widthAnchor.constraint(equalToConstant: 200)
    ]
    
    NSLayoutConstraint.activate(imageViewConstraints)
    NSLayoutConstraint.activate(levelLabelConstraints)
    NSLayoutConstraint.activate(statusLabelConstraints)
  }
}


