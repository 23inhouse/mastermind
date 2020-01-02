//
//  BoardTileView.swift
//  MasterMind
//
//  Created by Benjamin Lewis on 2/1/20.
//  Copyright © 2020 Benjamin Lewis. All rights reserved.
//

import UIKit

class BoardTileView: UIView {
  private let layout: UIView = {
    var layout = UIView()
    return layout
  }()

  private let borderColor: UIColor = #colorLiteral(red: 0.7395828382, green: 0.8683537049, blue: 0.8795605965, alpha: 1)
  private let borderWidth: CGFloat = 1

  override init(frame: CGRect) {
    super.init(frame: frame)

    setupViews()
    setupConstraints()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

private extension BoardTileView {
  func setupConstraints() {
    layout.constrain(to: self)
    layout.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      layout.heightAnchor.constraint(equalTo: layout.widthAnchor)
      ])
  }

  func setupViews() {
    layout.backgroundColor = .white
    layout.layer.borderColor = borderColor.cgColor
    layout.layer.borderWidth = borderWidth

    addSubview(layout)

  }
}
