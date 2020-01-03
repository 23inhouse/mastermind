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

  private let layoutTopSpacer = UIView()
  private let layoutBottomSpacer = UIView()
  private let boardLayoutLeftSpacer = UIView()
  private let boardLayoutRightSpacer = UIView()

  private let infoView = UIView()
  let boardView = BoardView()

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
    layoutTopSpacer.translatesAutoresizingMaskIntoConstraints = false
    layoutBottomSpacer.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      boardLayoutLeftSpacer.widthAnchor.constraint(equalTo: boardLayoutRightSpacer.widthAnchor),
      layoutBottomSpacer.heightAnchor.constraint(equalToConstant: 5),
      layoutBottomSpacer.heightAnchor.constraint(equalTo: layoutTopSpacer.heightAnchor),
      ])
  }

  func setupViews() {
    addSubview(layout)
    layout.addArrangedSubview(layoutTopSpacer)
    layout.addArrangedSubview(infoView)
    layout.addArrangedSubview(boardLayout)
    layout.addArrangedSubview(layoutBottomSpacer)
    boardLayout.addArrangedSubview(boardLayoutLeftSpacer)
    boardLayout.addArrangedSubview(boardView)
    boardLayout.addArrangedSubview(boardLayoutRightSpacer)
  }
}
