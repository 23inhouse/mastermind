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
  private(set) var gameVM = GameViewModel()

  var guessCount: Int? {
    guard let solvedIndex = solvedIndex else { return nil }
    return boardRowVCs.count - solvedIndex
  }
  var solvedIndex: Int? { return boardRowVCs.firstIndex(where: { $0.isSolved }) }
  var isComplete: Bool {
    return solvedIndex != nil
  }

  lazy var boardRowVCs: [BoardRowViewController] = {
    var boardRowVCs = [BoardRowViewController]()
    for i in 0 ..< gameVM.maxGuessCount {
      let boardRowVC = BoardRowViewController()
      boardRowVC.coordinator = coordinator
      boardRowVC.delegate = self
      boardRowVC.gameDelegate = self
      boardRowVC.game = gameVM.game
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
    gameVM.newSequence()
    redraw()
  }

  func redraw() {
    boardRowVCs.forEach { $0.reset(to: gameVM.game) }
    autofill()
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    gameVM.retrieveState()

    gameVM.average.bind { [unowned self] in self.gameView.controlsView.average = $0 }
    gameVM.best.bind { [unowned self] in self.gameView.controlsView.best = $0 }
    gameVM.playCount.bind { [unowned self] in self.gameView.controlsView.playCount = $0 }
    gameVM.score.bind { [unowned self] in self.gameView.controlsView.score = $0 }

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
}

extension GameViewController {
  static func fullReset(_ gameVC: GameViewController) {
    UserData.reset()
    gameVC.gameVM.retrieveState()
  }
}
