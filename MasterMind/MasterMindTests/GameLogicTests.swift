//
//  GameLogicTests.swift
//  MasterMindTests
//
//  Created by Benjamin Lewis on 18/1/20.
//  Copyright © 2020 Benjamin Lewis. All rights reserved.
//

import XCTest
@testable import MasterMind

class GameLogicTests: XCTestCase {
  func testEmpty() {
    XCTAssertEqual(GameLogic.empty, [" ", " ", " ", " "])
  }

  func testScoreDelta() {
    let expectations: [(Int, Int, Int)] = [
      (0, 5, 10),
      (9, 5, 10),
      (10, 5, 100),
      (20, 5, 200),
      (99, 5, 900),
      (100, 5, 1000),
    ]

    for (playCount, guessCount, expectedScore) in expectations {
      let score = GameLogic.scoreDelta(playCount: playCount, guessCount: guessCount)

      XCTAssertEqual(score, expectedScore)
    }
  }

  func testNew() {
    var game = GameLogic()

    let sequence = game.sequence

    game.new()

    XCTAssertNotEqual(game.sequence, sequence)
  }

  func testIncrementPlay() {
    var game = GameLogic()

    let expectations: [(Int, (Double, Int, Int, Int))] = [
      (5, (5.0, 5, 10, 1)),
      (7, (6.0, 5, 11, 2)),
      (3, (5.0, 3, 51, 3)),
    ]

    for (guessCount, values) in expectations {
      let (average, best, score, playCount) = values
      game.incrementPlay(with: guessCount)

      XCTAssertEqual(game.average, average)
      XCTAssertEqual(game.best, best)
      XCTAssertEqual(game.score, score)
      XCTAssertEqual(game.playCount, playCount)
    }
  }
}
