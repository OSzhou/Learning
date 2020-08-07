//
//  FMPrintViewController.swift
//  GCD_Test
//
//  Created by Zhouheng on 2020/8/5.
//  Copyright © 2020 tataUFO. All rights reserved.
//

import UIKit
/**
 你不是赵雷的南方姑娘，
 不是马頔的傲寒，
 不是宋冬野的董小姐，
 不是李志的港岛妹妹，
 不是海龟的玛卡瑞纳，
 不是贰佰的玫瑰，
 不是尧十三的北方女王，
 不是花粥的良人，
 不是低苦艾的小花花，
 不是陈粒的祝星。
 你只是一只远在北方孤独藏着秘密的鬼，
 总有一天他会找到你，
 带你回家，告诉你所有的方向
 */
class FMPrintViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .gray
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.test()
        self.test2()
    }
    
    func test() {
        let queue = DispatchQueue.global()//(label: "concurrentQueue", attributes: .concurrent)
        queue.async {
            print(" --- 111 --- ")
            self.perform(#selector(self.performAction), with: nil, afterDelay: 0)
            
//            RunLoop.current.add(Port(), forMode: .default)
            RunLoop.current.run(mode: .default, before: .distantFuture)
            
        }
    }

    @objc func performAction() {
        print(" --- 222 --- ")
    }
    
    func test2() {
        let thread = Thread {
            print("\(#function) --- 111 ---")
            
            RunLoop.current.add(Port(), forMode: .default)
            RunLoop.current.run(mode: .default, before: .distantFuture)
        }
        thread.start()
        self.perform(#selector(perform2Action), on: thread, with: nil, waitUntilDone: true)
    }
    
    @objc func perform2Action() {
        print("\(#function) --- 222 --- ")
    }
}
