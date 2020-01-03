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

  var averageScore: Double {
    guard scores.count > 0 else { return 0 }
    return Double(scores.reduce(0, +)) / Double(scores.count)
  }
  var bestScore: Int { return scores.sorted().first ?? 0 }
  var scores = [Int]() {
    didSet {
      updateControlsView()
    }
  }
  var score: Double {
    guard averageScore > 0 else { return 0 }
    return 5.0 / averageScore
  }

  let rowCount: Int = 10
  lazy var boardRowVCs: [BoardRowViewController] = {
    var boardRowVCs = [BoardRowViewController]()
    for i in 0 ..< rowCount {
      let boardRowVC = BoardRowViewController()
      boardRowVC.coordinator = coordinator
      boardRowVC.delegate = self
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

  func updateScore() {
    guard let solvedIndex = boardRowVCs.firstIndex(where: { $0.isSolved }) else { return }

    let currentScore = boardRowVCs.count - solvedIndex
    UserData.storeScores(score: currentScore)
    scores = UserData.retrieveScores()
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    scores = UserData.retrieveScores()

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

  func updateControlsView() {
    gameView.controlsView.avg = averageScore
    gameView.controlsView.best = bestScore
    gameView.controlsView.score = score
  }
}

extension GameViewController {
  static let empty = [" ", " ", " ", " "]
  static let firstRowGuess = ["❤️", "🧡", "💛", "💚"]
  static let secondRowGuess = ["💙", "💙", "💜", "💜"]
  static let options = ["❤️", "🧡", "💛", "💚", "💙", "💜"]

  static func fullReset(_ gameVC: GameViewController) {
    UserData.reset()
    gameVC.scores = UserData.retrieveScores()
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
