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

  var correctSequence: [String]?

  private(set) var boardRowView = BoardRowView()
  var guesses: [String] { return boardRowView.buttonLabels }

  var index: Int = 0
  var isActive: Bool = false

  var isComplete: Bool {
    for guess in guesses where guess == " " { return false }
    return true
  }
  var isSolved: Bool { return guesses == correctSequence }
  var score: [String] { return calculateScore() }

  func reset(to new: [String]) {
    correctSequence = new
    set(guesses: GameViewController.empty)
    boardRowView.set(score: BoardRowViewController.empty)
  }

  func setScore(for guesses: [String]? = nil) {
    if let guesses = guesses { set(guesses: guesses) }
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
  func calculateScore() -> [String] {
    guard var correctSequence = correctSequence else { return BoardRowViewController.empty }

    var score = [String]()
    var guesses = self.guesses

    for (i, guess) in guesses.enumerated() where guess == correctSequence[i] {
      score.append(BoardRowViewController.correct)
      guesses[i] = "found"
      correctSequence[i] = "found"
    }

    for (i, remaining) in guesses.enumerated() {
      if remaining == "found" { continue }

      if let otherIndex = correctSequence.firstIndex(of: remaining) {
        score.append(BoardRowViewController.found)
        guesses[i] = "found"
        correctSequence[otherIndex] = "found"
      }
    }

    return score
  }

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

extension BoardRowViewController {
  static let empty = [" ", " ", " ", " "]
  static let correct = "⚫️"
  static let found = "⚪️"
}
