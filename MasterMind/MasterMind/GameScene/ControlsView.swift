//
//  ControlsView.swift
//  MasterMind
//
//  Created by Benjamin Lewis on 3/1/20.
//  Copyright © 2020 Benjamin Lewis. All rights reserved.
//

import UIKit

class ControlsView: UIView {
  var average: Double = 0 {
    didSet {
      buttons[2].setLabel(bestAvgText, numberOfLines: 3)
    }
  }
  var best: Int = 0 {
    didSet {
      buttons[2].setLabel(bestAvgText, numberOfLines: 3)
    }
  }
  private var bestAvgText: String { return String(format: "Best: %d\nAvg\n%0.3f", best, average) }

  var playCount: Int = 0 {
    didSet {
      buttons[1].setLabel(playCountText, numberOfLines: 2)
    }
  }
  private var playCountText: String { return String(format: "Game\n#%d", playCount) }

  var score: Int = 0 {
    didSet {
      buttons[3].setLabel(scoreText, numberOfLines: 2)
    }
  }
  private var scoreText: String { return String(format: "Score\n%d", score) }

  var lastResetDate: Date = Date()

  private let infoPerRow: Int = 5

  private let layout: UIStackView = {
    let layout = UIStackView.make(.equal, axis: .horizontal)
    layout.spacing = 5
    return layout
  }()

  private(set) var buttons = [TileButton]()

  override init(frame: CGRect) {
    super.init(frame: frame)

    setupViews()
    setupConstraints()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

private extension ControlsView {
  func setupConstraints() {
    layout.constrain(to: self)
  }

  func setupViews() {
    addSubview(layout)
    for _ in 0 ..< infoPerRow {
      let boardTileView = BoardTileView()
      layout.addArrangedSubview(boardTileView)
      buttons.append(boardTileView.button)
    }

    buttons[0].setLabel("🌊")
    buttons[4].setLabel("🌈")
  }
}
