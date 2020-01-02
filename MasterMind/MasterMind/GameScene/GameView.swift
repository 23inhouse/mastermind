//
//  GameView.swift
//  MasterMind
//
//  Created by Benjamin Lewis on 2/1/20.
//  Copyright © 2020 Benjamin Lewis. All rights reserved.
//

import UIKit

class GameView: UIView {
  private let layout: UIStackView = {
    let layout = UIStackView.make(.filled, axis: .vertical)
    return layout
  }()

  private let boardLayout: UIStackView = {
    let boardLayout = UIStackView.make(.filled, axis: .horizontal)
    return boardLayout
  }()

  private let layoutSpacer = UIView()
  private let boardLayoutLeftSpacer = UIView()
  private let boardLayoutRightSpacer = UIView()

  private let infoView = UIView()
  private let boardView = BoardView()

  override init(frame: CGRect) {
    super.init(frame: frame)

    setupViews()
    setupConstraints()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

private extension GameView {
  func setupConstraints() {
    layout.constrain(to: self)
    boardLayoutLeftSpacer.translatesAutoresizingMaskIntoConstraints = false
    boardLayoutRightSpacer.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      boardLayoutLeftSpacer.widthAnchor.constraint(equalTo: boardLayoutRightSpacer.widthAnchor)
      ])
  }

  func setupViews() {
    addSubview(layout)
    layout.addArrangedSubview(layoutSpacer)
    layout.addArrangedSubview(infoView)
    layout.addArrangedSubview(boardLayout)
    boardLayout.addArrangedSubview(boardLayoutLeftSpacer)
    boardLayout.addArrangedSubview(boardView)
    boardLayout.addArrangedSubview(boardLayoutRightSpacer)
  }
}
