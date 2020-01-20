//
//  GameLogic.swift
//  MasterMind
//
//  Created by Benjamin Lewis on 13/1/20.
//  Copyright © 2020 Benjamin Lewis. All rights reserved.
//

import Foundation

struct GameLogic {
  let maxGuessCount = 10

  var average: Double = 0
  var best: Int = 0
  var playCount: Int = 0
  var score: Int = 0

  private(set) var sequence = GameLogic.newSequence()

  mutating func new() {
    sequence = GameLogic.newSequence()
  }

  mutating func incrementPlay(with guessCount: Int) {
    update(best: guessCount)
    update(score: guessCount)
    update(average: guessCount)
    incrementPlayCount()
  }
}

private extension GameLogic {
  mutating func incrementPlayCount() {
    playCount += 1
  }

  func score(for guessCount: Int) -> Int {
    return GameLogic.scoreDelta(playCount: playCount, guessCount: guessCount)
  }

  mutating func update(average value: Int) {
    let calculator = AverageCalculator.init(average: average, itemCount: playCount)
    average = calculator.calc(for: value)
  }

  mutating func update(best value: Int) {
    guard best != 0 else {
      best = value
      return
    }
    best = value < best ? value : best
  }

  mutating func update(score key: Int) {
    score += score(for: key)
  }
}

extension GameLogic {
  static let empty = [" ", " ", " ", " "]
  static let firstRowGuess = [ "💚", "💚", "🧡", "🧡"]
  static let secondRowGuess = ["❤️", "💛", "💙", "💜"]
  static let options = ["❤️", "🧡", "💛", "💚", "💙", "💜"]

  static let scores: [Int: Int] = [
    1: 160,
    2: 80,
    3: 40,
    4: 20,
    5: 10,
    6: 5,
    7: 1,
    8: 1,
    9: 1,
    10: 0,
  ]

  static func newSequence() -> [String] {
    return [random(), random(), random(), random()]
  }

  static func random() -> String {
    return options.randomElement() ?? "🧡"
  }

  static func scoreDelta(playCount: Int, guessCount: Int) -> Int {
    guard let score = scores[guessCount] else { return 0 }
    let multiplier = playCount + 1
    return score * multiplier
  }
}
