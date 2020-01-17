//
//  GameViewController+ButtonDelegate.swift.swift
//  MasterMind
//
//  Created by Benjamin Lewis on 3/1/20.
//  Copyright © 2020 Benjamin Lewis. All rights reserved.
//

import Foundation

extension GameViewController: ButtonDelegate {
  func didTouchButton(_ value: String, at index: Int) {
    if GameLogic.options.contains(value) {
      activeBoardRowVC?.boardRowVM.fillFirstEmpty(with: value)
      return
    }

    perform(action: value)
  }
}
