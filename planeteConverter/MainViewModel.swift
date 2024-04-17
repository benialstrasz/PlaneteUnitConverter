//
//  MainViewController.swift
//  planeteConverter
//
//  Created by Benedikt Gottstein on 16.04.2024.
//

import Foundation
import SwiftUI

@MainActor
class MainViewModel: ObservableObject {
 
  @AppStorage("showNotes") var showNotes: Bool = false
    
  
 func someFunc() async {
   do {
     // do stuff
   } catch {
     // handle error
   }
 }
  
}
