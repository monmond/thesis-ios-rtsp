//
//  PlayerView.swift
//  thesis-ios-rtsp
//
//  Created by Sasawat Sankosik on 11/11/2562 BE.
//  Copyright © 2562 ssankosik. All rights reserved.
//

import UIKit

class PlayerView: UIView {
    
  var id: String!
  var player: IJKMediaPlayback?
  
  init(url: URL, id: String) {
    super.init(frame: .zero)
    self.id = id
    backgroundColor = .black
    let options = IJKFFOptions.byDefault()
    player = IJKFFMoviePlayerController(contentURL: url, with: options)
    player?.view?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    player?.view?.frame = bounds
    player?.scalingMode = .aspectFit
    player?.shouldAutoplay = true
    autoresizesSubviews = true
    addSubview(player!.view)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func Log(_ message: String) {
    print("[PLAYER VIEW \(id!)] -> \(message)")
  }
  
  func viewWillAppear() {
    player?.prepareToPlay()
  }
  
  func viewDidDisappear() {
    player?.shutdown()
  }
  
  /*
     MPMovieLoadStateUnknown        = 0,
     MPMovieLoadStatePlayable       = 1 << 0,
     MPMovieLoadStatePlaythroughOK  = 1 << 1,
     (Playback will be automatically started in this state when shouldAutoplay is YES)
     MPMovieLoadStateStalled        = 1 << 2,
     (Playback will be automatically paused in this state, if started)
  */
  @objc func loadStateDidChange(_ notification: Notification) {
    let logHeader = "\(#function) \(player?.loadState ?? []):"
    if let loadState = player?.loadState {
      if loadState.contains(.playthroughOK) {
        Log("\(logHeader) playthroughOK")
      } else if loadState.contains(.stalled) {
        Log("\(logHeader) stalled")
      } else {
        fatalError()
      }
    }
  }
  
  /*
    MPMovieFinishReasonPlaybackEnded,
    MPMovieFinishReasonPlaybackError,
    MPMovieFinishReasonUserExited
  */
  @objc func playbackDidFinish(_ notification: Notification) {
    let reason = notification.userInfo?[IJKMPMoviePlayerPlaybackDidFinishReasonUserInfoKey] as! Int
    let logHeader = "\(#function):"
    switch reason {
    case IJKMPMovieFinishReason.playbackEnded.rawValue:
      Log("\(logHeader) playbackEnded")
    case IJKMPMovieFinishReason.userExited.rawValue:
      Log("\(logHeader) userExited")
    case IJKMPMovieFinishReason.playbackError.rawValue:
      Log("\(logHeader) playbackError")
    default:
      fatalError()
      break
    }
  }
  
  @objc func preparedToPlayDidChange(notification: Notification) {
    print("\(#function)")
  }
  
  /*
    MPMoviePlaybackStateStopped,
    MPMoviePlaybackStatePlaying,
    MPMoviePlaybackStatePaused,
    MPMoviePlaybackStateInterrupted,
    MPMoviePlaybackStateSeekingForward,
    MPMoviePlaybackStateSeekingBackward
  */
  @objc func playbackStateDidChange(_ notification: Notification) {
    guard player != nil else {
      return
    }
    let logHeader = "\(#function) \(player?.playbackState.rawValue ?? 0):"
    switch player!.playbackState {
    case .stopped:
      Log("\(logHeader) stoped")
      break
    case .playing:
      Log("\(logHeader) playing")
      break
    case .paused:
      Log("\(logHeader) paused")
      break
    case .interrupted:
      Log("\(logHeader) interrupted")
      break
    case .seekingForward, .seekingBackward:
      Log("\(logHeader) seeking")
      break
    @unknown default:
      fatalError()
      break
    }
  }
  
  func installMovieNotificationObservers() {
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(self.loadStateDidChange),
                                           name: .IJKMPMoviePlayerLoadStateDidChange,
                                           object: player)
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(self.playbackDidFinish),
                                           name: .IJKMPMoviePlayerPlaybackDidFinish,
                                           object: player)
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(self.preparedToPlayDidChange),
                                           name: .IJKMPMediaPlaybackIsPreparedToPlayDidChange,
                                           object: player)
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(self.playbackStateDidChange),
                                           name: .IJKMPMoviePlayerPlaybackStateDidChange,
                                           object: player)
  }
  
  /*
    Remove the movie notification observers from the movie object.
  */
  func removeMovieNotificationObservers() {
    NotificationCenter.default.removeObserver(self,
                                              name: .IJKMPMoviePlayerLoadStateDidChange,
                                              object: player)
    NotificationCenter.default.removeObserver(self,
                                              name: .IJKMPMoviePlayerPlaybackDidFinish,
                                              object: player)
    NotificationCenter.default.removeObserver(self,
                                              name: .IJKMPMediaPlaybackIsPreparedToPlayDidChange,
                                              object: player)
    NotificationCenter.default.removeObserver(self,
                                              name: .IJKMPMoviePlayerPlaybackStateDidChange,
                                              object: player)
  }
  
}

