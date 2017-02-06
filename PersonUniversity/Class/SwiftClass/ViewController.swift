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
        self.view.backgroundColor = UIColor.purple;
        let button:UIButton = UIButton(type:.custom);
        button.frame = CGRect(x:100,y:200,width:200,height:40)
        button.backgroundColor = UIColor.gray
        self.view.addSubview(button)
        button.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
    }

    
    
    func buttonClick(){
        self.dismiss(animated: true) { 
            print("diss VC succed")
        };
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


