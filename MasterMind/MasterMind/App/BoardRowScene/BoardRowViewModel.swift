//
//  BoardRowViewModel.swift
//  MasterMind
//
//  Created by Benjamin Lewis on 15/1/20.
//  Copyright © 2020 Benjamin Lewis. All rights reserved.
//

import Foundation

class BoardRowViewModel {
  var guess: GuessLogic = GuessLogic(correctSequence: []) {
    didSet {
      sequence.value = guess.correctSequence
      guesses.value = guess.guesses
      score.value = guess.score
    }
  }

  var sequence: Box<[String]> = Box([])
  var guesses: Box<[String]> = Box(GameLogic.empty)
  var score: Box<[String]> = Box([])

  var isComplete: Bool { return guess.isComplete }
  var isSolved: Bool { return guess.isSolved }

  func fillFirstEmpty(with value: String) {
    guard let index = guesses.value.firstIndex(where: { $0 == " "}) else { return }
    guesses.value[index] = value
  }

  func set(value: String, at index: Int) {
    guesses.value[index] = value
  }
}
