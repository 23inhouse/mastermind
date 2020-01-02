//
//  Coordinator.swift
//  Github
//
//  Created by Benjamin Lewis on 19/12/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

import Foundation

protocol Coordinator {
  var appViewController: AppViewController { get set }

  func start()
}
