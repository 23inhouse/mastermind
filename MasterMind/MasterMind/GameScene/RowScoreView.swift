//
//  RowScoreView.swift
//  MasterMind
//
//  Created by Benjamin Lewis on 2/1/20.
//  Copyright © 2020 Benjamin Lewis. All rights reserved.
//

import UIKit

class RowScoreView: UIView {
  private let scorePerColumn: Int = 2
  private let scorePerRow: Int = 2

  private let layout: UIStackView = {
    let layout = UIStackView.make(.equal, axis: .vertical)
    layout.spacing = 2
    return layout
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)

    setupViews()
    setupConstraints()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

private extension RowScoreView {
  func setupConstraints() {
    layout.constrain(to: self)
  }

  func setupViews() {
    addSubview(layout)

    for _ in 0 ..< scorePerColumn {
      let rowsStackView = UIStackView.make(.equal, axis: .horizontal)
      rowsStackView.spacing = 2
      layout.addArrangedSubview(rowsStackView)

      for _ in 0 ..< scorePerRow {
        let tileScoreView = TileScoreView()
        rowsStackView.addArrangedSubview(tileScoreView)
      }
    }
  }
}
