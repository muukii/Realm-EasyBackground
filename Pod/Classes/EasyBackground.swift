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
            if let queue = objc_getAssociatedObject(self, &StoredProperties.queue) as? NSOperationQueue {
                return queue
            }
            
            let queue = self.createDefaultQueue()
            self.queue = queue
            return queue
        }
        set {
            objc_setAssociatedObject(self, &StoredProperties.queue, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }        
    }
    
    public func writeBackground(block: (Realm throws -> Void)) {
        self.writeBackground(block, completion: { _ in })
    }
    
    public func writeBackground(block: (Realm throws -> Void), completion: (ErrorType? -> Void)) {
        
        self.queue.addOperationWithBlock {
            autoreleasepool {
                do {
                    let realm = try Realm(configuration: self.configuration)
                    realm.beginWrite()
                    
                    do {
                        try block(realm)
                        try realm.commitWrite()
                        
                        NSOperationQueue.mainQueue().addOperationWithBlock {
                            completion(nil)
                        }
                    } catch {
                        realm.cancelWrite()
                        NSOperationQueue.mainQueue().addOperationWithBlock {
                            completion(error)
                        }
                    }
                } catch {
                    NSOperationQueue.mainQueue().addOperationWithBlock {
                        completion(error)
                    }
                }                
            }
        }
    }
    
    private enum StoredProperties {
        static var queue: Void?
    }
    
    private func createDefaultQueue() -> NSOperationQueue {
        let queue = NSOperationQueue()
        queue.maxConcurrentOperationCount = 1
        queue.qualityOfService = NSQualityOfService.Default
        return queue
    }
}