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

  private(set) var boardRowView = BoardRowView()
  private(set) var boardRowVM = BoardRowViewModel()

  var sequence: [String]? { return boardRowVM.sequence.value }
  var guesses: [String] { return boardRowVM.guesses.value }

  var index: Int = 0
  var isActive: Bool = false
  var isComplete: Bool { return boardRowVM.isComplete }
  var isSolved: Bool { return boardRowVM.isSolved }

  func complete(_ gameVM: GameViewModel, guessCount: Int?) {
    guard isComplete else { return }
    guard let guessCount = guessCount else { return }

    if isSolved {
      gameVM.add(score: guessCount)
      return
    }

    if index == 0 {
      gameVM.add(score: guessCount)
      DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { UserData.reset() }
      return
    }
  }

  func set(guesses: [String]) {
    guard let sequence = sequence else { return }
    let guess = GuessLogic(correctSequence: sequence, guesses: guesses)
    boardRowVM.guess = guess
  }

  func set(sequence: [String]?) {
    guard let sequence = sequence else { return }
    let guess = GuessLogic(correctSequence: sequence, guesses: guesses)
    boardRowVM.guess = guess
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    boardRowVM.guesses.bind { [unowned self] in self.boardRowView.set(guesses: $0) }
    boardRowVM.score.bind { [unowned self] in self.boardRowView.set(score: $0) }

    setupViews()
    setupConstraints()
    setupButtonDelegates()
  }
}

private extension BoardRowViewController {
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
