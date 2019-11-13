//
//  PlayerVC.swift
//  thesis-ios-rtsp
//
//  Created by Sasawat Sankosik on 11/11/2562 BE.
//  Copyright © 2562 ssankosik. All rights reserved.
//

import UIKit
import SnapKit

class PlayerVC: UIViewController {
  
  let rtsp = "rtsp://wowzaec2demo.streamlock.net/vod/mp4:BigBuckBunny_115k.mov"
  var playerView01: PlayerView!
  var playerView02: PlayerView!
  
  override var prefersStatusBarHidden: Bool {
    return false
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = String(describing: Self.self)
    view.backgroundColor = .white
    #if DEBUG
    IJKFFMoviePlayerController.setLogReport(true)
    IJKFFMoviePlayerController.setLogLevel(k_IJK_LOG_DEBUG)
    #else
    IJKFFMoviePlayerController.setLogReport(false)
    IJKFFMoviePlayerController.setLogLevel(k_IJK_LOG_INFO)
    #endif
    IJKFFMoviePlayerController.checkIfFFmpegVersionMatch(true)
    
    playerView01 = PlayerView(url: URL(string: rtsp)!, id: "1")
    playerView01.backgroundColor = .red
    playerView01.translatesAutoresizingMaskIntoConstraints = false
    playerView02 = PlayerView(url: URL(string: rtsp)!, id: "2")
    playerView02.backgroundColor = .blue
    playerView02.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(playerView02)
    view.addSubview(playerView01)
    
    playerView01.snp.makeConstraints {
      $0.top.equalTo(view.snp.topMargin)
      $0.right.equalToSuperview()
      $0.left.equalToSuperview()
      $0.height.equalTo(self.playerView01.snp.width).multipliedBy(0.75)
    }
    playerView02.snp.makeConstraints {
      $0.top.equalTo(self.playerView01.snp.bottom)
      $0.right.equalToSuperview()
      $0.left.equalToSuperview()
      $0.height.equalTo(self.playerView02.snp.width).multipliedBy(0.75)
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    playerView01.viewWillAppear()
    playerView02.viewWillAppear()
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    playerView01.viewDidDisappear()
    playerView02.viewDidDisappear()
  }
  
  override var shouldAutorotate: Bool {
    return true
  }
  
  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    return .all
  }
  
}
