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
    guard let text = sender.label.text else { return }

    if isActive {
      sender.setLabel(" ")
    } else {
      guard text != " " else { return }
      buttonDelegate?.didTouchButton(sender)
    }
  }
}
