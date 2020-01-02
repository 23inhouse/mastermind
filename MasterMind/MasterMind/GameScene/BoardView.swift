//
//  BoardView.swift
//  MasterMind
//
//  Created by Benjamin Lewis on 2/1/20.
//  Copyright © 2020 Benjamin Lewis. All rights reserved.
//

import UIKit

class BoardView: UIView {
  private let rows: Int = 10

  private let layout: UIStackView = {
    let layout = UIStackView.make(.equal, axis: .vertical)
    layout.spacing = 5
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

private extension BoardView {
  func setupConstraints() {
    layout.constrain(to: self)
  }

  func setupViews() {
    addSubview(layout)

    for _ in 0 ..< rows {
      let boardRowView = BoardRowView()
      layout.addArrangedSubview(boardRowView)
    }
  }
}
