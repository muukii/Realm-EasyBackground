//
//  EasyBackground.swift
//  Pods
//
//  Created by Hiroshi Kimura on 2/12/16.
//
//

import Foundation
import RealmSwift

extension Realm {
    
    public var queue: NSOperationQueue {
        get {
            if let queue = objc_getAssociatedObject(self, &StoredPropaties.queue) as? NSOperationQueue {
                return queue
            }
            
            let queue = self.createDefaultQueue()
            self.queue = queue
            return queue
        }
        set {
            objc_setAssociatedObject(self, &StoredPropaties.queue, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    public func writeBackground(block: (store: Realm) -> Void, completion: () -> Void) {
        
        self.queue.addOperationWithBlock {
            autoreleasepool {
                do {
                    let realm = try Realm(configuration: self.configuration)
                    try realm.write {
                        block(store: realm)
                    }
                } catch {
                    // FIXME: Error Handling
                }
                NSOperationQueue.mainQueue().addOperationWithBlock {
                    completion()
                }
            }
        }
    }
    
    private enum StoredPropaties {
        static var queue: Void?
    }
    
    private func createDefaultQueue() -> NSOperationQueue {
        let queue = NSOperationQueue()
        queue.maxConcurrentOperationCount = 1
        queue.qualityOfService = NSQualityOfService.Default
        return queue
    }
}