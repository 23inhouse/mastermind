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

  override func viewDidLoad() {
    super.viewDidLoad()

    setupViews()
    setupConstraints()

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
  static let firstRowGuess = ["❤️", "🧡", "💛", "💚"]
  static let secondRowGuess = ["💙", "💙", "💜", "💜"]
  static let options = ["❤️", "🧡", "💛", "💚", "💙", "💜"]

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
