//
//  Pending Operation Queue.swift
//  Wijnderlust
//
//  Created by Matt Gibbs on 07/02/2018.
//  Copyright © 2018 MG Creative Services. All rights reserved.
//

import Foundation

class PendingOperations {
    var downloadsInProgress = [IndexPath: Operation]()
    
    let downloadQueue = OperationQueue()
}
