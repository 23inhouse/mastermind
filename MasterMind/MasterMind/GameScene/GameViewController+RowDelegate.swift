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

    guard index > 0 else {
      reset()
      return
    }

    if index == (boardRowVCs.count - 2) && !currentVC.isActive && !currentVC.isComplete {
      autofill()
      return
    }
    guard currentVC.isActive else { return }
    guard currentVC.isComplete else { return }
    currentVC.setScore()
    currentVC.isActive = false

    boardRowVCs[index - 1].isActive = true
  }
}
