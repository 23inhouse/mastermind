//
//  GameViewModel.swift
//  MasterMind
//
//  Created by Benjamin Lewis on 15/1/20.
//  Copyright © 2020 Benjamin Lewis. All rights reserved.
//

import Foundation

class GameViewModel {
  var game: GameLogic = GameLogic() {
    didSet {
      average.value = game.average
      best.value = game.best
      playCount.value = game.playCount
      score.value = game.score
    }
  }

  var average: Box<Double> = Box(0)
  var best: Box<Int> = Box(0)
  var playCount: Box<Int> = Box(0)
  var score: Box<Int> = Box(0)

  var maxGuessCount: Int { return game.maxGuessCount }
  var sequence: [String] { return game.sequence }

  func add(score: Int) {
    game.incrementPlay(with: score)
    UserData.store(game: game)
  }

  func newSequence() {
    game.new()
  }

  func retrieveState() {
     game = UserData.retrieve(game: game)
  }
}
