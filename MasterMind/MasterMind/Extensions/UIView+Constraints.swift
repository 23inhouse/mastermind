//
//  UIView+Constraints.swift
//  Github
//
//  Created by Benjamin Lewis on 19/12/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

import UIKit

extension UIView {
  func constrain(to parentView: UIView, margin: CGFloat = 0) {
    translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: margin),
      trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -margin),
      topAnchor.constraint(equalTo: parentView.topAnchor, constant: margin),
      bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: -margin),
      ])
  }

  func constrain(to layoutGuide: UILayoutGuide, margin: CGFloat = 0) {
    translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: margin),
      trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -margin),
      topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: margin),
      bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: -margin),
      ])
  }
}
