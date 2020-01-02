//
//  UIStackView+Builders.swift
//  MasterMind
//
//  Created by Benjamin Lewis on 2/1/20.
//  Copyright © 2020 Benjamin Lewis. All rights reserved.
//

import UIKit

extension UIStackView {
  enum Kinds {
    case equal
    case filled
  }

  static func make(_ type: Kinds, axis: NSLayoutConstraint.Axis) -> UIStackView {
    let stackView = UIStackView()
    switch type {
    case .equal:
      stackView.alignment = .fill
      stackView.distribution = .fillEqually
    case .filled:
      stackView.alignment = .fill
    }
    stackView.axis = axis
    return stackView
  }
}
