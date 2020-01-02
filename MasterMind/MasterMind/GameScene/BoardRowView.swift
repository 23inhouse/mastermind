//
//  BoardRowView.swift
//  MasterMind
//
//  Created by Benjamin Lewis on 2/1/20.
//  Copyright © 2020 Benjamin Lewis. All rights reserved.
//

import UIKit

class BoardRowView: UIView {
  private let tilesPerRow: Int = 4

  private let layout: UIStackView = {
    let layout = UIStackView.make(.equal, axis: .horizontal)
    layout.spacing = 5
    return layout
  }()

  private let rowScoreView = RowScoreView()

  override init(frame: CGRect) {
    super.init(frame: frame)

    setupViews()
    setupConstraints()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

private extension BoardRowView {
  func setupConstraints() {
    layout.constrain(to: self)
  }

  func setupViews() {
    addSubview(layout)
    layout.addArrangedSubview(rowScoreView)

    for _ in 0 ..< tilesPerRow {
      let boardTileView = BoardTileView()
      layout.addArrangedSubview(boardTileView)
    }
  }
}
