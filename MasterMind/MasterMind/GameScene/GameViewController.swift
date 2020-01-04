//
//  GameViewController.swift
//  MasterMind
//
//  Created by Benjamin Lewis on 2/1/20.
//  Copyright © 2020 Benjamin Lewis. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
  weak var coordinator: AppCoordinator?

  private(set) var gameView = GameView()

  var correctSequence = GameViewController.newSequence()

  var average: Double = 0 {
    didSet { gameView.controlsView.average = average }
  }
  var best: Int = 0 {
    didSet { gameView.controlsView.best = best }
  }
  var playCount: Int = 0 {
    didSet { gameView.controlsView.playCount = playCount }
  }
  var score: Int = 0 {
    didSet { gameView.controlsView.score = score }
  }

  let rowCount: Int = 10
  lazy var boardRowVCs: [BoardRowViewController] = {
    var boardRowVCs = [BoardRowViewController]()
    for i in 0 ..< rowCount {
      let boardRowVC = BoardRowViewController()
      boardRowVC.coordinator = coordinator
      boardRowVC.delegate = self
      boardRowVC.gameDelegate = self
      boardRowVC.index = i
      boardRowVC.correctSequence = correctSequence
      boardRowVCs.append(boardRowVC)
    }
    return boardRowVCs
  }()

  func autofill() {
    boardRowVCs[9].setScore(for: GameViewController.firstRowGuess)
    boardRowVCs[8].setScore(for: GameViewController.secondRowGuess)
    activate(index: 7)
  }

  func reset() {
    GameViewController.reset(self)
    boardRowVCs.forEach { $0.reset(to: correctSequence) }
    let lastIndex = boardRowVCs.count - 1
    activate(index: lastIndex)
  }

  func updateControlsView() {
    gameView.controlsView.average = average
    gameView.controlsView.best = best
    gameView.controlsView.playCount = playCount
    gameView.controlsView.score = score
  }

  func updateScore() {
    guard let solvedIndex = boardRowVCs.firstIndex(where: { $0.isSolved }) else { return }

    let scoreAmount: [Int: Int] = [
      9: 160,
      8: 80,
      7: 40,
      6: 20,
      5: 10,
      4: 5,
      3: 1,
      2: 1,
      1: 1,
      0: 0,
    ]

    let currentRow = boardRowVCs.count - solvedIndex
    best = currentRow < best ? currentRow : best
    score += scoreAmount[solvedIndex] ?? 0
    playCount += 1
    average = ((average * Double(playCount - 1)) + Double(currentRow)) / Double(playCount)

    updateControlsView()

    UserData.store(.average, average)
    UserData.store(.best, best)
    UserData.store(.playCount, playCount)
    UserData.store(.score, score)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    average = UserData.retrieve(.average)
    best = UserData.retrieve(.best)
    playCount = UserData.retrieve(.playCount)
    score = UserData.retrieve(.score)

    updateControlsView()

    setupViews()
    setupConstraints()
    setupButtonDelegates()

    if let lastVC = boardRowVCs.last {
      lastVC.isActive = true
    }
  }
}

private extension GameViewController {
  func activate(index: Int) {
    guard let newActiveRow = boardRowVCs[optional: index] else { return }

    boardRowVCs.forEach { $0.isActive = false }
    newActiveRow.isActive = true
  }

  func setupButtonDelegates() {
    gameView.controlsView.buttons.enumerated().forEach { i, button in
      button.delegate = self
      button.index = i
    }
  }

  func setupConstraints() {
    gameView.constrain(to: view.safeAreaLayoutGuide)
  }

  func setupViews() {
    view.addSubview(gameView)

    for boardRowVC in boardRowVCs {
      addChild(boardRowVC)
      _ = boardRowVC.view
      gameView.boardView.add(row: boardRowVC.boardRowView)
    }
  }
}

extension GameViewController {
  static let empty = [" ", " ", " ", " "]
  static let firstRowGuess = [ "💚", "💚", "🧡", "🧡"]
  static let secondRowGuess = ["❤️", "💛", "💙", "💜"]
  static let options = ["❤️", "🧡", "💛", "💚", "💙", "💜"]

  static func fullReset(_ gameVC: GameViewController) {
    UserData.reset()
    gameVC.average = UserData.retrieve(.average)
    gameVC.best = UserData.retrieve(.best)
    gameVC.playCount = UserData.retrieve(.playCount)
    gameVC.score = UserData.retrieve(.score)
  }

  static func newSequence() -> [String] {
    return [
      options.randomElement() ?? "🧡",
      options.randomElement() ?? "🧡",
      options.randomElement() ?? "🧡",
      options.randomElement() ?? "🧡",
    ]
  }

  static func reset(_ gameVC: GameViewController) {
    gameVC.correctSequence = newSequence()
  }
}
