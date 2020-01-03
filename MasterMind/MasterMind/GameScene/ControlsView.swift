//
//  ControlsView.swift
//  MasterMind
//
//  Created by Benjamin Lewis on 3/1/20.
//  Copyright © 2020 Benjamin Lewis. All rights reserved.
//

import UIKit

class ControlsView: UIView {
  var best: Int = 0 {
    didSet {
      let rounded = ControlsView.round(number: avg)
      buttons[1].setLabel("Best: \(best)\n\nAverage\n\(rounded)", numberOfLines: 4)
    }
  }
  var avg: Double = 0 {
    didSet {
      let rounded = ControlsView.round(number: avg)
      buttons[1].setLabel("Best: \(best)\n\nAverage\n\(rounded)", numberOfLines: 4)
      score = 5.0 / avg
    }
  }
  var score: Double = 0 {
    didSet {
      let rounded = ControlsView.round(number: score)
      buttons[2].setLabel("Score\n\(rounded)", numberOfLines: 2)
    }
  }

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

    buttons[0].setLabel("🚽")
    //    buttons[1].setLabel("Best: \(best)\nAvg: \(avg)", numberOfLines: 2)
    //    buttons[2].setLabel("Score\n\(score)", numberOfLines: 2)
    buttons[3].setLabel("🧻")
    buttons[4].setLabel("💩")
  }
}

extension ControlsView {
  static let precision: Double = 1000

  static func round(number: Double) -> Double {
    return Double((precision * number).rounded() / precision)
  }
}
