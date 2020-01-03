//
//  TileButton.swift
//  MasterMind
//
//  Created by Benjamin Lewis on 2/1/20.
//  Copyright © 2020 Benjamin Lewis. All rights reserved.
//

import UIKit

class TileButton: UIView {
  weak var delegate: ButtonDelegate?

  var index: Int = 0

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

  func setLabel(_ text: String) {
    label.text = text
  }

  override init(frame: CGRect) {
    super.init(frame: frame)

    setupViews()
    setupConstraints()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

private extension TileButton {
  func setupConstraints() {
    label.constrain(to: self)
  }

  func setupViews() {
    addSubview(label)
    label.text = " "

    let touch = UITapGestureRecognizer(target: self, action: #selector(touchButton))
    addGestureRecognizer(touch)
  }

  @objc func touchButton() {
    delegate?.didTouchButton(self)
  }
}
