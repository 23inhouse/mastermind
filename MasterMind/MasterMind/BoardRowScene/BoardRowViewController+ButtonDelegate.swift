//
//  BoardRowViewController+ButtonDelegate.swift
//  MasterMind
//
//  Created by Benjamin Lewis on 2/1/20.
//  Copyright © 2020 Benjamin Lewis. All rights reserved.
//

import Foundation

extension BoardRowViewController: ButtonDelegate {
  func didTouchButton(_ sender: TileButton) {
    guard isActive else { return }
    guard let text = sender.label.text else { return }
    let options = GameViewController.options + [" "]
    var index = -1

    if text != " " {
      index = options.firstIndex(of: text) ?? -1
    }

    if index >= options.count - 1 {
      index = -1
    }
    index += 1

    sender.setLabel(options[index])
  }
}
