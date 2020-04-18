//
//  backend.swift
//  cSwiftApp_1
//
//  Created by Asesh Shrestha on 1/22/20.
//  Copyright © 2020 Asesh Shrestha. All rights reserved.
//

import Foundation

class CBaseBackend {
  init() {
    print("From the initializer of CBaseBackend class")
  }
  
  deinit {
    print("From the deinitializer of CBaseBackend class")
  }
	
	func foo() {
		print("From the foo method fo CBaseBackend class")
	}
}

class CBackend: CBaseBackend {
	override init() {
		print("From the initializer of CBackend class")
	}
	
	deinit {
		print("From the deinitializer of CBackend class")
	}
	
	override func foo() {
		print("From the foo method of CBackend class")
	}
}
