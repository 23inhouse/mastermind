//
//  BoardRowViewController+ButtonDelegate.swift
//  MasterMind
//
//  Created by Benjamin Lewis on 2/1/20.
//  Copyright © 2020 Benjamin Lewis. All rights reserved.
//

import Foundation

extension BoardRowViewController: ButtonDelegate {
  func didTouchButton(_ value: String, at index: Int) {

    if isActive {
      boardRowVM.set(value: " ", at: index)
    } else {
      guard value != " " else { return }
      buttonDelegate?.didTouchButton(value, at: index)
    }
  }
}
