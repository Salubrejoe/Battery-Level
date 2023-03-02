//
//  BingVC.swift
//  Battery Level
//
//  Created by Lore P on 02/03/2023.
//

import Foundation
import UIKit

class ViewController: UIViewController {
  
  // Create a label to display the battery percentage
  let batteryLabel = UILabel()
  
  // Create an image view to display the battery symbol
  let batteryImageView = UIImageView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .systemBackground
    
    // Enable battery monitoring
    UIDevice.current.isBatteryMonitoringEnabled = true
    
    // Add an observer for the battery level change notification
    NotificationCenter.default.addObserver(self, selector: #selector(batteryLevelDidChange), name: UIDevice.batteryLevelDidChangeNotification, object: nil)
    
    NotificationCenter.default.addObserver(self, selector: #selector(stateDidChange), name: UIDevice.batteryStateDidChangeNotification, object: nil)
    
    // Configure the label
    batteryLabel.text = "\(Int(UIDevice.current.batteryLevel * 100))%"
    batteryLabel.font = UIFont.systemFont(ofSize: 24)
    batteryLabel.textAlignment = .center
    
    // Configure the image view
    batteryImageView.image = UIImage(systemName: "battery.100")
    batteryImageView.tintColor = .label
    batteryImageView.contentMode = .scaleAspectFit
    
    // Add the label and image view as subviews
    view.addSubview(batteryLabel)
    view.addSubview(batteryImageView)
    
    // Set up constraints for layout
    batteryLabel.translatesAutoresizingMaskIntoConstraints = false
    batteryImageView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      // Center the label horizontally and vertically
      batteryLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      batteryLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      
      // Place the image view above and to the left of the label with some spacing
      batteryImageView.bottomAnchor.constraint(equalTo: batteryLabel.topAnchor, constant: -8),
      batteryImageView.centerXAnchor.constraint(equalTo: batteryLabel.centerXAnchor),
      batteryImageView.widthAnchor.constraint(equalToConstant: 200),
      batteryImageView.heightAnchor.constraint(equalToConstant: 30)
      
    ])
  }
  
  
  @objc func stateDidChange() {
    let state = UIDevice.current.batteryState.rawValue
    
    switch state {
    case 2:
      batteryImageView.tintColor = .systemYellow
    default:
      batteryImageView.tintColor = .label
    }
    
  }
  
  @objc func batteryLevelDidChange(_ notification: Notification) {
    
    // Update the label text with the current battery level
    let level = Int(UIDevice.current.batteryLevel * 100)
    self.batteryLabel.text = "\(level)%"
    
    // Update the image view with an appropriate system symbol based on the level range
    switch level {
    case 0...10:
      self.batteryImageView.image = UIImage(systemName: "battery.0")
    case 11...25:
      self.batteryImageView.image = UIImage(systemName: "battery.25")
    case 26...50:
      self.batteryImageView.image = UIImage(systemName: "battery.50")
    case 51...75:
      self.batteryImageView.image = UIImage(systemName: "battery.75")
    default:
      self.batteryImageView.image = UIImage(systemName: "battery.100")
      
    }
    
  }
  
}
