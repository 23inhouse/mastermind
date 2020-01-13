//
//  GameViewController+ButtonDelegate.swift.swift
//  MasterMind
//
//  Created by Benjamin Lewis on 3/1/20.
//  Copyright © 2020 Benjamin Lewis. All rights reserved.
//

import Foundation

extension GameViewController: ButtonDelegate {
  func didTouchButton(_ sender: TileButton) {
    let label = sender.getLabel()
    if GameLogic.options.contains(label) {
      guard let currentRowVC = boardRowVCs.first(where: { $0.isActive }) else { return }
      guard let index = currentRowVC.boardRowView.buttonLabels.firstIndex(where: { $0 == " "}) else { return }

      currentRowVC.boardRowView.buttons[index].setLabel(label)
      return
    }

    let index = sender.index
    if index == 0 {
      GameViewController.fullReset(self)
      reset()
    } else if index == 4 {
      guard isComplete else { return }
      reset()
    }
  }
}
