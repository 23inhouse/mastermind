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

  var activeBoardRowVC: BoardRowViewController? { return boardRowVCs.first(where: { $0.isActive }) }
  var guessCount: Int? {
    guard let solvedIndex = solvedIndex else { return nil }
    return boardRowVCs.count - solvedIndex
  }
  var solvedIndex: Int? { return boardRowVCs.firstIndex(where: { $0.isSolved }) }
  var isComplete: Bool { return solvedIndex != nil }

  lazy var boardRowVCs: [BoardRowViewController] = {
    var boardRowVCs = [BoardRowViewController]()
    for i in 0 ..< gameVM.maxGuessCount {
      let boardRowVC = BoardRowViewController()
      boardRowVC.coordinator = coordinator
      boardRowVC.delegate = self
      boardRowVC.buttonDelegate = self
      boardRowVC.index = i
      boardRowVC.set(sequence: gameVM.sequence)
      boardRowVCs.append(boardRowVC)
    }
    return boardRowVCs
  }()

  func activate(index: Int) {
    guard let newActiveRow = boardRowVCs[optional: index] else { return }

    boardRowVCs.forEach { $0.isActive = false }
    newActiveRow.isActive = true
  }

  func playCount(_ playCount: Int) -> Int {
    return self.isComplete ? playCount : playCount + 1
  }

  func perform(action value: String) {
    guard ["💩", "🌈"].contains(value) else { return }

    if value == "💩" {
      GameViewController.fullReset(self)
    }
    if value == "🌈" && !isComplete { return }

    reset()
  }

  func reset() {
    boardRowVCs.forEach { vc in vc.set(guesses: GuessLogic.empty) }
    gameVM.newSequence()
    redraw()
  }

  func redraw() {
    boardRowVCs.forEach { vc in vc.set(sequence: gameVM.sequence) }
    autofill()
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    gameVM.retrieveState()

    gameVM.average.bind { [unowned self] in self.gameView.controlsView.average = $0 }
    gameVM.best.bind { [unowned self] in self.gameView.controlsView.best = $0 }
    gameVM.playCount.bind { [unowned self] in self.gameView.controlsView.playCount = self.playCount($0) }
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
    boardRowVCs[rowCount - 1].set(guesses: GameLogic.firstRowGuess)
    boardRowVCs[rowCount - 2].set(guesses: GameLogic.secondRowGuess)
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
