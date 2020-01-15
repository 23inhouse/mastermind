//
//  BoardRowViewController.swift
//  MasterMind
//
//  Created by Benjamin Lewis on 2/1/20.
//  Copyright © 2020 Benjamin Lewis. All rights reserved.
//

import UIKit

class BoardRowViewController: UIViewController {
  weak var coordinator: AppCoordinator?
  weak var delegate: RowDelegate?
  weak var buttonDelegate: ButtonDelegate?

  var game: GameLogic?

  private(set) var boardRowView = BoardRowView()
  var guesses: [String] { return boardRowView.buttonLabels }

  var index: Int = 0
  var isActive: Bool = false

  var isComplete: Bool {
    for guess in guesses where guess == " " { return false }
    return true
  }
  var isSolved: Bool { return guesses == game?.sequence }

  func reset(to new: GameLogic) {
    game = new
    set(guesses: GameLogic.empty)
    boardRowView.set(score: GuessLogic.empty)
  }

  func setScore(for guesses: [String]? = nil) {
    guard let game = game else { return }
    if let guesses = guesses { set(guesses: guesses) }

    let guess = GuessLogic(correctSequence: game.sequence)
    let score = guess.score(for: self.guesses)
    boardRowView.set(score: score)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    setupViews()
    setupConstraints()
    setupButtonDelegates()
  }
}

private extension BoardRowViewController {
  func set(guesses: [String]) {
    for (i, guess) in guesses.enumerated() {
      boardRowView.buttons[i].label.text = guess
    }
  }

  func setupButtonDelegates() {
    boardRowView.buttons.enumerated().forEach { i, button in
      button.delegate = self
      button.index = i
    }

    boardRowView.completeButton.delegate = delegate
    boardRowView.completeButton.delegateFrom = self
  }

  func setupConstraints() {
    boardRowView.constrain(to: view)
  }

  func setupViews() {
    view.addSubview(boardRowView)
  }
}
