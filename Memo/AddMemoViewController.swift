//
//  AddMemoViewController.swift
//  Memo
//
//  Created by nttr on 2017/07/20.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit
import NCMB

class AddMemoViewController: UIViewController {
    
    @IBOutlet var memoTextView: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func save(){
        let inputText = memoTextView.text
        let ud = UserDefaults.standard
        if ud.array(forKey: KeyManager.saveKey) != nil {
            var saveMemoArray = ud.array(forKey: KeyManager.saveKey) as! [String]
            if inputText != nil{
            saveMemoArray.append(inputText!)
            }
            else{
                print("何も入力されてない")
            }
            ud.set(saveMemoArray, forKey: KeyManager.saveKey)
        }
        else{
            var newMemoArray = [String]()
            if inputText != nil {
                newMemoArray.append(inputText!)
            }
            else{
                print("何も入力されてない")
            }
            ud.set(newMemoArray, forKey: KeyManager.saveKey)
        }
        ud.synchronize()
        self.dismiss(animated: true, completion: nil)
        
        let object = NCMBObject(className: "Memo")
        object?.setObject(inputText, forKey: "text")
        object?.saveInBackground({ (error) in
            if error != nil{
                print("error")
            }
            else{
                print("sucsess")
            }
        })
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
