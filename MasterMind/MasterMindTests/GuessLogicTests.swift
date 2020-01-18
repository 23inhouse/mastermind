//
//  GuessLogicTests.swift
//  MasterMindTests
//
//  Created by Benjamin Lewis on 18/1/20.
//  Copyright © 2020 Benjamin Lewis. All rights reserved.
//

import XCTest
@testable import MasterMind

class GuessLogicTests: XCTestCase {
  let (a, b, c, d, e, f) = ("A", "B", "C", "D", "E", "F")
  lazy var correctSequence: [String] = [a, b, c, d]

  func testEmpty() {
    XCTAssertEqual(GuessLogic.empty, [" ", " ", " ", " "])
  }

  func testInit() {
    var guess: GuessLogic

    let expectations: [(([String], [String]), [String])] = [
      ((correctSequence, GameLogic.empty), GuessLogic.empty),
      ((correctSequence, [c, d, e, f]), ["⚪️", "⚪️"]),
    ]

    for (args, score) in expectations {
      let (correctSequence, guesses) = args
      guess = GuessLogic(correctSequence: correctSequence, guesses: guesses)

      XCTAssertEqual(guess.score, score)
    }
  }

  func testIsComplete() {
    let expectations: [([String], Bool)] = [
      (GameLogic.empty, false),
      ([a, d, e, f], true),
      ([a, d, e], false),
      ([a, d, e, " "], false),
    ]

    for (guesses, complete) in expectations {
      var guess = GuessLogic(correctSequence: correctSequence)
      guess.set(guesses: guesses)

      XCTAssertEqual(guess.isComplete, complete)
    }
  }

  func testIsSolved() {
    let expectations: [([String], Bool)] = [
      (GameLogic.empty, false),
      (correctSequence, true),
      ([a, d, e, f], false),
    ]

    for (guesses, solved) in expectations {
      var guess = GuessLogic(correctSequence: correctSequence)
      guess.set(guesses: guesses)

      XCTAssertEqual(guess.isSolved, solved)
    }
  }

  func testSet() {
    let expectations: [([String], [String])] = [
      (GameLogic.empty, GuessLogic.empty),
      ([a, d, e, f], ["⚫️", "⚪️"]),
      (correctSequence, ["⚫️", "⚫️", "⚫️", "⚫️"]),
      (correctSequence.reversed(), ["⚪️", "⚪️", "⚪️", "⚪️"]),
      ([a, d, e], GuessLogic.empty),
    ]

    for (guesses, score) in expectations {
      var guess = GuessLogic(correctSequence: correctSequence)
      guess.set(guesses: guesses)

      XCTAssertEqual(guess.score, score)
    }
  }
}
