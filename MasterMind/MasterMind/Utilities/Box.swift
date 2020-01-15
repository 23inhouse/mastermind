//
//  Box.swift
//  MasterMind
//
//  Created by Benjamin Lewis on 15/1/20.
//  Copyright © 2020 Benjamin Lewis. All rights reserved.
//

import Foundation

class Box<T> {
  typealias Listener = (T) -> Void
  var listener: Listener?

  var value: T {
    didSet {
      listener?(value)
    }
  }

  func bind(listener: Listener?) {
    self.listener = listener
    listener?(value)
  }

  init(_ value: T) {
    self.value = value
  }
}
