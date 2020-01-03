//
//  ButtonDelegate.swift
//  MasterMind
//
//  Created by Benjamin Lewis on 2/1/20.
//  Copyright © 2020 Benjamin Lewis. All rights reserved.
//

import Foundation

protocol ButtonDelegate: AnyObject {
  func didTouchButton(_ sender: TileButton)
}
