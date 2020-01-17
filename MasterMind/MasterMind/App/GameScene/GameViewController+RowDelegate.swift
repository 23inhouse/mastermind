//
//  GameViewController+RowDelegate.swift
//  MasterMind
//
//  Created by Benjamin Lewis on 2/1/20.
//  Copyright © 2020 Benjamin Lewis. All rights reserved.
//

import Foundation

extension GameViewController: RowDelegate {
  func didCompleteRow(_ sender: BoardRowViewController? = nil) {
    guard let currentVC = sender else { return }
    guard currentVC.isActive else { return }

    currentVC.set(guesses: currentVC.guesses)
    currentVC.complete(gameVM, guessCount: guessCount)

    guard currentVC.isComplete else { return }
    let index = currentVC.index
    activate(index: index - 1)
  }
}
