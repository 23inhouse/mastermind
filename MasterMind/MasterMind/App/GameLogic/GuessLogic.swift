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

  func score(for guesses: [String]) -> [String] {
    var currentSequence = correctSequence

    var score = [String]()
    var guesses = guesses

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

    return score
  }
}

extension GuessLogic {
  static let empty = [" ", " ", " ", " "]
  static let correct = "⚫️"
  static let found = "⚪️"
}
