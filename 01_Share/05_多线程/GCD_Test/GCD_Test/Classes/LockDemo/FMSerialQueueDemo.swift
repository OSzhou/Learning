//
//  FMSerialQueueDemo.swift
//  GCD_Test
//
//  Created by Zhouheng on 2020/8/7.
//  Copyright © 2020 tataUFO. All rights reserved.
//

import UIKit

class FMSerialQueueDemo: FMBaseDemo {
    var moneyQueue = DispatchQueue(label: "moneyQueue")
    var ticketQueue = DispatchQueue(label: "ticketQueue")
    
    override func __saveMoney() {
        moneyQueue.sync {
            super.__saveMoney()
        }
    }
    
    override func __drawMoney() {
        moneyQueue.sync {
            super.__drawMoney()
        }
    }
    
    override func __saleTicket() {
        ticketQueue.sync {
            super.__saleTicket()
        }
    }
}
