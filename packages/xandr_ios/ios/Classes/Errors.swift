//
//  Errors.swift
//  xandr_ios
//
//  Created by markus korn on 14.07.24.
//

import Foundation

enum XandrPluginError: Error {
  case notValidSource
  case noMemberId
  case runtimeError(String)
}
