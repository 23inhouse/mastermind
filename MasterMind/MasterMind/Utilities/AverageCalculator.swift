//
//  AverageCalculator.swift
//  MasterMind
//
//  Created by Benjamin Lewis on 13/1/20.
//  Copyright © 2020 Benjamin Lewis. All rights reserved.
//

import Foundation

struct AverageCalculator {
  let average: Double
  let itemCount: Int

  func calc(for value: Int) -> Double {
    return ((average * Double(itemCount)) + Double(value)) / Double(itemCount + 1)
  }
}
