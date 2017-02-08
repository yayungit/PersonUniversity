//
//  ViewController.swift
//  PersonUniversity
//
//  Created by 何亚运 on 2017/2/6.
//  Copyright © 2017年 YYStar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.init(hex: 0xff4521)
        
        let button:UIButton = UIButton(type:.custom);
        button.frame = CGRect.init(x: 30, y: 200, width: 200, height: 40)
        button.backgroundColor = UIColor.gray
        
        self.view.addSubview(button)
        button.setTitle("Alter AutoLayoutViewController", for: .normal)
        button.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        
        let dismissButton:UIButton! = UIButton.init(type: .custom)
        dismissButton.frame = CGRect.init(x: 30, y: 260, width: 200, height: 40)
        dismissButton.backgroundColor = UIColor.gray
        self.view.addSubview(dismissButton)
        dismissButton.setTitle("Dismiss current VC", for: .normal)
        dismissButton.addTarget(self, action: #selector(disMissVC), for: .touchUpInside)
        
    }

    func disMissVC() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func buttonClick(){
//        self.dismiss(animated: true) { 
//            print("diss VC succed")
//        };
        let autoVC = AutoLayoutViewController.init();
        
        self.present(autoVC, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


