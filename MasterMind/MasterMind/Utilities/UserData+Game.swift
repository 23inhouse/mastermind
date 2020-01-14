//
//  UserData+Game.swift
//  MasterMind
//
//  Created by Benjamin Lewis on 14/1/20.
//  Copyright © 2020 Benjamin Lewis. All rights reserved.
//

import Foundation

extension UserData {
  static func retrieve(game: GameLogic) -> GameLogic {
    var game = game
    game.average = retrieve(.average)
    game.best = retrieve(.best)
    game.playCount = retrieve(.playCount)
    game.score = retrieve(.score)
    return game
  }

  static func store(game: GameLogic) {
    store(.average, game.average)
    store(.best, game.best)
    store(.playCount, game.playCount)
    store(.score, game.score)
  }
}
