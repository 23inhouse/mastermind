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
    let index = currentVC.index

    guard currentVC.isActive else { return }
    guard currentVC.isComplete else { return }
    currentVC.setScore()

    if currentVC.isSolved {
      updateScore()
      return
    }

    if index == 0 {
      updateScore()
      DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { UserData.reset() }
      return
    }

    activate(index: index - 1)
  }
}
