//
//  FMBarrierViewController.swift
//  GCD_Test
//
//  Created by Zhouheng on 2020/8/6.
//  Copyright © 2020 tataUFO. All rights reserved.
//

import UIKit

class FMBarrierViewController: UIViewController {

    let queue = DispatchQueue(label: "concurrentQueue", attributes: .concurrent)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .gray
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        test()
        test2()
    }

    func test2() {
        for _ in 0..<10 {
            
            self.read2()
            self.read2()
            self.read2()
            self.write2()
            
        }
    }
    
    func read2() {
        queue.async {
            Thread.sleep(forTimeInterval: 1)
            print(" --- read2 --- ")
        }
    }
    
    func write2() {
        queue.async(flags: .barrier) {
            Thread.sleep(forTimeInterval: 1)
            print(" --- write2 --- ")
        }
    }
        
    func test() {
        for _ in 0..<10 {
            queue.async {
                self.read()
            }
            
            queue.async {
                self.read()
            }
            
            queue.async {
                self.read()
            }
            
            queue.async(flags: .barrier) {
                self.write()
            }
        }
    }
    
    func read() {
        Thread.sleep(forTimeInterval: 1)
        print(" --- read --- ")
    }
    
    func write() {
        Thread.sleep(forTimeInterval: 3)
        print(" --- write --- ")
    }
}
