//
//  NewViewController.swift
//  Battery Level
//
//  Created by Lore P on 02/03/2023.
//

import UIKit

class NewViewController: UIViewController {
  private var b100Image = UIImage(systemName: "battery.100")
  private var b75Image = UIImage(systemName: "battery.75")
  private var b50Image = UIImage(systemName: "battery.50")
  private var b25Image = UIImage(systemName: "battery.25")
  private var b0Image = UIImage(systemName: "battery.0")
  
  
  private var imageView: UIImageView!
  private var levelLabel: UILabel!
  private var statusLabel: UILabel!
  
  let dagger = UIDevice.current
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Battery level"
    navigationController?.navigationBar.prefersLargeTitles = true
    
    view.backgroundColor = .systemBackground
    
    configureUI()
  }
}

extension NewViewController {
  
  private func configureUI() {
    
    configureImageView()
    configureLevelLabel()
    configureStatusLabel()
    
    view.addSubview(imageView)
    view.addSubview(levelLabel)
    view.addSubview(statusLabel)
    
    imageView.translatesAutoresizingMaskIntoConstraints = false
    levelLabel.translatesAutoresizingMaskIntoConstraints = false
    statusLabel.translatesAutoresizingMaskIntoConstraints = false
    
    let imageViewConstraints = [
      imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),
      imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 5),
      imageView.heightAnchor.constraint(equalToConstant: 150),
      imageView.widthAnchor.constraint(equalToConstant: 200)
    ]
    
    let levelLabelConstraints = [
      levelLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 30),
      levelLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      levelLabel.heightAnchor.constraint(equalToConstant: 50),
      levelLabel.widthAnchor.constraint(equalToConstant: 200)
    ]
    
    let statusLabelConstraints = [
      statusLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 45),
      statusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      statusLabel.heightAnchor.constraint(equalToConstant: 50),
      statusLabel.widthAnchor.constraint(equalToConstant: 200)
    ]
    
    NSLayoutConstraint.activate(imageViewConstraints)
    NSLayoutConstraint.activate(levelLabelConstraints)
    NSLayoutConstraint.activate(statusLabelConstraints)
  }
  
  
  
  fileprivate func getBatteryInfo() {
    dagger.isBatteryMonitoringEnabled = true
    
    switch dagger.batteryState.rawValue {
    case 0:
      imageView.tintColor = .systemRed
      imageView.image = UIImage(systemName: "xmark.octagon.fill")
    case 1:
      imageView.tintColor = .label
    case 2:
      imageView.tintColor = .systemYellow
    case 3:
      imageView.tintColor = .systemYellow
    default:
      imageView.tintColor = .systemCyan
    }
    
    
    
    let currentCharge = dagger.batteryLevel
    // Set correct Image
    if currentCharge >= 0.87 {
      imageView.image = b100Image
    } else if currentCharge < 0.87 && currentCharge >= 0.75 {
      imageView.image = b75Image
    } else if currentCharge < 0.75 && currentCharge >= 0.50 {
      imageView.image = b50Image
    } else if currentCharge < 0.50 && currentCharge >= 0.25 {
      imageView.image = b25Image
    } else if currentCharge < 0.25 {
      imageView.image = b0Image
    }
    dagger.isBatteryMonitoringEnabled = false
  }
  
  func configureImageView() {
    
    imageView = UIImageView(image: b50Image)
    imageView.contentMode = .scaleAspectFit
    
    getBatteryInfo()
  

  }
  
  func configureLevelLabel() {
    
    levelLabel = UILabel()
    levelLabel.textAlignment = .center
    levelLabel.font = .systemFont(ofSize: 30, weight: .semibold)
    levelLabel.text = "Unknown"
    
    // Set up Percentage Label
    dagger.isBatteryMonitoringEnabled = true
    
    let currentCharge = dagger.batteryLevel
    let chargeFormatted = (currentCharge*100).formatted()
    if currentCharge >= 0.01 {
      levelLabel.text = "\(chargeFormatted)%"
    } else {
      levelLabel.tintColor = .systemRed
    }
    
    dagger.isBatteryMonitoringEnabled = false
  }
  
  func configureStatusLabel() {
    statusLabel = UILabel()
    statusLabel.textAlignment = .center
    statusLabel.font = .systemFont(ofSize: 15)
    statusLabel.text = ""
  }
  
}
