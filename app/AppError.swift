//
//  AppError.swift
//  thesis-ios-rtsp
//
//  Created by Sasawat Sankosik on 12/11/2562 BE.
//  Copyright © 2562 ssankosik. All rights reserved.
//

import Foundation

enum AppError: Error, LocalizedError {
  
  case unknown
  case custom(String)
  case inputWrongOrMissing

  var errorDescription: String? {
    var result = ""
    switch self {
    case .unknown:
      result = "Something went wrong."
    case let .custom(message):
      result = message
    case .inputWrongOrMissing:
      result = "Input wrong or missing."
    }
    return result
  }
  
}
