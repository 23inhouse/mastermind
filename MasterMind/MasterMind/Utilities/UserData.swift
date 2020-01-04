//
//  GameViewController.swift
//  MasterMind
//
//  Created by Benjamin Lewis on 3/1/20.
//  Copyright © 2020 Benjamin Lewis. All rights reserved.
//

import Foundation

struct UserData {
  enum Key: String {
    case average
    case best
    case playCount
    case score
  }

  private static let defaults = UserDefaults.standard

  static func reset() {
    defaults.set(0, forKey: Key.average.rawValue)
    defaults.set(10, forKey: Key.best.rawValue)
    defaults.set(0, forKey: Key.playCount.rawValue)
    defaults.set(0, forKey: Key.score.rawValue)
  }

  static func retrieve(_ key: Key) -> Double {
    return defaults.double(forKey: key.rawValue)
  }

  static func retrieve(_ key: Key) -> Int {
    return defaults.integer(forKey: key.rawValue)
  }

  static func store(_ key: Key, _ value: Int) {
    defaults.set(value, forKey: key.rawValue)
  }

  static func store(_ key: Key, _ value: Double) {
    defaults.set(value, forKey: key.rawValue)
  }
}
