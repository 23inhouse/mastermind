//
//  GuessLogic.swift
//  MasterMind
//
//  Created by Benjamin Lewis on 13/1/20.
//  Copyright © 2020 Benjamin Lewis. All rights reserved.
//

import Foundation

struct GuessLogic {
  let correctSequence: [String]
  var guesses = [String]() {
    didSet {
      guard isComplete else { return }
      calcScore()
    }
  }
  var score = [String]()

  var isComplete: Bool {
    for guess in guesses where guess == " " { return false }
    return true
  }
  var isSolved: Bool { return guesses == correctSequence }

  mutating func set(guesses: [String]) {
    self.guesses = guesses
  }

  mutating func calcScore() {
    guard isComplete else { return }
    var currentSequence = correctSequence

    var score = [String]()
    var guesses = self.guesses

    for (i, guess) in guesses.enumerated() where guess == currentSequence[i] {
      score.append(GuessLogic.correct)
      guesses[i] = "found"
      currentSequence[i] = "found"
    }

    for (i, remaining) in guesses.enumerated() {
      if remaining == "found" { continue }

      if let otherIndex = currentSequence.firstIndex(of: remaining) {
        score.append(GuessLogic.found)
        guesses[i] = "found"
        currentSequence[otherIndex] = "found"
      }
    }

    self.score = score
  }

  init(correctSequence: [String], guesses: [String] = GameLogic.empty) {
    self.correctSequence = correctSequence
    self.guesses = guesses
    calcScore()
  }
}

extension GuessLogic {
  static let empty = [" ", " ", " ", " "]
  static let correct = "⚫️"
  static let found = "⚪️"
}
