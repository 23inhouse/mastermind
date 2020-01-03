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
    let index = sender.index
    if index == 0 {
      GameViewController.fullReset(self)
    } else if index == 3 {
      reset()
    } else if index == 4 {
      reset()
    }
  }
}
