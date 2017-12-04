//  Copyright © 2016 Compass. All rights reserved.

import Foundation

public class Variable<T> {
    internal let subject: Replay<T?>
    internal var lock = NSRecursiveLock()
    internal var currentValue: T?

    public var value: T? {
        get {
            lock.lock(); defer { lock.unlock() }
            return currentValue
        }
        set {
            lock.lock()
            currentValue = newValue
            lock.unlock()

            subject.on(.next(newValue))
        }
    }

    public init(_ value: T?) {
        currentValue = value
        subject = Replay<T?>(1)
        self.value = value
    }

    public func asObservable() -> Observable<T?> {
        return subject
    }

    deinit {
        subject.on(.done)
    }
}
