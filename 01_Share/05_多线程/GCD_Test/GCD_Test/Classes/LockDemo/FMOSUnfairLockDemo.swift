//
//  FMOSUnfairLockDemo.swift
//  GCD_Test
//
//  Created by Zhouheng on 2020/8/7.
//  Copyright © 2020 tataUFO. All rights reserved.
//

import UIKit
import libkern

class FMOSUnfairLockDemo: FMBaseDemo {
    var moneyLock = os_unfair_lock(_os_unfair_lock_opaque: UInt32(OS_SPINLOCK_INIT))
    var ticketLock = os_unfair_lock(_os_unfair_lock_opaque: UInt32(OS_SPINLOCK_INIT))
    
    override func __saveMoney() {
        os_unfair_lock_lock(&moneyLock)
        super.__saveMoney()
        os_unfair_lock_unlock(&moneyLock)
    }
    
    override func __drawMoney() {
        os_unfair_lock_lock(&moneyLock)
        super.__drawMoney()
        os_unfair_lock_unlock(&moneyLock)
    }
    
    override func __saleTicket() {
        os_unfair_lock_lock(&ticketLock)
        super.__saleTicket()
        os_unfair_lock_unlock(&ticketLock)
    }
}
