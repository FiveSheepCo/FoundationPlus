//
//  Timer+ScheduledTimer.swift
//  
//
//  Created by SplittyDev on 08.07.24.
//

import Foundation

public extension Timer {
    
    /**
     Creates and returns a timer that will invoke the specified block after the given time interval.
     
     - Parameters:
        - timeInterval: The number of seconds between firings of the timer. If interval is less than or equal to 0.0, this method chooses the nonnegative value of 0.0001 seconds instead.
        - repeats: If true, the timer will repeatedly reschedule itself until invalidated. If false, the timer will be invalidated after it fires.
        - block: A block to be executed when the timer fires. The block takes a single NSTimer parameter and has no return value.
     
     - Returns: A newly created `Timer` object, configured according to the specified parameters.
     */
    @available(tvOS 10.0, *)
    @available(OSX 10.12, *)
    @discardableResult
    static func scheduledTimer(
        withTimeInterval timeInterval: TimeInterval,
        repeats: Bool = false,
        block: @Sendable @escaping () -> Void
    ) -> Timer {
        self.scheduledTimer(withTimeInterval: timeInterval, repeats: repeats, block: { _ in
            block()
        })
    }
}
