//
//  TileScoreView.swift
//  MasterMind
//
//  Created by Benjamin Lewis on 2/1/20.
//  Copyright © 2020 Benjamin Lewis. All rights reserved.
//

import UIKit

class TileScoreView: UIView {
  private let layout: UIView = {
    var layout = UIView()
    return layout
  }()

  let label: UILabel = {
    let label = UILabel()
    label.font = label.font.withSize(100)
    label.adjustsFontSizeToFitWidth = true
    label.numberOfLines = 1
    label.baselineAdjustment = .alignCenters
    label.textAlignment = .center
    label.isUserInteractionEnabled = true
    return label
  }()

  private let borderColor: UIColor = #colorLiteral(red: 0.7395828382, green: 0.8683537049, blue: 0.8795605965, alpha: 1)
  private let borderWidth: CGFloat = 0.5

  override init(frame: CGRect) {
    super.init(frame: frame)

    setupViews()
    setupConstraints()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

private extension TileScoreView {
  func setupConstraints() {
    layout.constrain(to: self)
    layout.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      layout.heightAnchor.constraint(equalTo: layout.widthAnchor)
      ])
    label.constrain(to: layout, margin: 5)
  }

  func setupViews() {
    layout.backgroundColor = .white
    layout.layer.borderColor = borderColor.cgColor
    layout.layer.borderWidth = borderWidth

    label.text = " "

    addSubview(layout)
    layout.addSubview(label)
  }
}
