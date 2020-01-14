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

  var game = GameLogic() {
    didSet {
      updateControlsView()
    }
  }

  var solvedIndex: Int? { return boardRowVCs.firstIndex(where: { $0.isSolved }) }
  var isComplete: Bool {
    return solvedIndex != nil
  }

  lazy var boardRowVCs: [BoardRowViewController] = {
    var boardRowVCs = [BoardRowViewController]()
    for i in 0 ..< game.maxGuessCount {
      let boardRowVC = BoardRowViewController()
      boardRowVC.coordinator = coordinator
      boardRowVC.delegate = self
      boardRowVC.gameDelegate = self
      boardRowVC.game = game
      boardRowVC.index = i
      boardRowVCs.append(boardRowVC)
    }
    return boardRowVCs
  }()

  func activate(index: Int) {
    guard let newActiveRow = boardRowVCs[optional: index] else { return }

    boardRowVCs.forEach { $0.isActive = false }
    newActiveRow.isActive = true
  }

  func reset() {
    game.newSequence()
    redraw()
  }

  func redraw() {
    boardRowVCs.forEach { $0.reset(to: game) }
    autofill()
  }

  func updateScore() {
    guard let solvedIndex = solvedIndex else { return }

    let guessCount = boardRowVCs.count - solvedIndex

    game.incrementPlay(with: guessCount)

    updateControlsView()

    UserData.store(game: game)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    game = UserData.retrieve(game: game)

    updateControlsView()

    setupViews()
    setupConstraints()
    setupButtonDelegates()

    redraw()
  }
}

private extension GameViewController {
  func autofill() {
    let rowCount = boardRowVCs.count
    boardRowVCs[rowCount - 1].setScore(for: GameLogic.firstRowGuess)
    boardRowVCs[rowCount - 2].setScore(for: GameLogic.secondRowGuess)
    activate(index: rowCount - 3)
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
    gameView.controlsView.average = game.average
    gameView.controlsView.best = game.best
    gameView.controlsView.playCount = game.playCount
    gameView.controlsView.score = game.score
  }
}

extension GameViewController {
  static func fullReset(_ gameVC: GameViewController) {
    UserData.reset()
    gameVC.game = UserData.retrieve(game: gameVC.game)
  }
}
