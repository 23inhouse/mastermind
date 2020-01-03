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
    case scores
  }

  private static let defaults = UserDefaults.standard

  static func reset() {
    defaults.set([], forKey: Key.scores.rawValue)
  }

  static func retrieveScores() -> [Int] {
    let searches = defaults.object(forKey: Key.scores.rawValue) as? [Int]
    return searches ?? []
  }

  static func storeScores(score: Int) {
    var scores = retrieveScores()
    scores.append(score)
    defaults.set(scores, forKey: Key.scores.rawValue)
  }
}
