//
//  ContentView.swift
//  Battery Level Watch Watch App
//
//  Created by Lore P on 02/03/2023.
//
import SwiftUI

struct ContentView: View {
  
  // Create a state variable to store the battery level
  @State var batteryLevel: Float = 0
  
  // Create a timer to update the battery level every second
  let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
  
  var body: some View {
    
    // Use a VStack to stack the views vertically
    VStack {
      
      // Use an Image view to display the battery symbol
      Image(systemName: getBatteryImageName())
        .font(.largeTitle)
        .foregroundColor(.green)
      
      // Use a Text view to display the battery percentage
      Text("\(Int(batteryLevel * 100))%")
        .font(.subheadline)
        .foregroundColor(.primary)
      
    }
    // Add some padding around the views
    .padding()
    
    // Update the battery level when the timer fires
    .onReceive(timer) { _ in
      
      // Get the current device's battery level
      self.batteryLevel = WKInterfaceDevice.current().batteryLevel
      
      // Enable battery monitoring if not already enabled
      if !WKInterfaceDevice.current().isBatteryMonitoringEnabled {
        WKInterfaceDevice.current().isBatteryMonitoringEnabled = true
      }
      
    }
    
  }
  
  // A helper function to return an appropriate system image name based on the battery level range
  func getBatteryImageName() -> String {
    
    switch Int(batteryLevel * 100) {
    case 0...10:
      return "battery.0"
    case 11...25:
      return "battery.25"
    case 26...50:
      return "battery.50"
    case 51...75:
      return "battery.75"
    default:
      return "battery.100"
      
    }
    
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

