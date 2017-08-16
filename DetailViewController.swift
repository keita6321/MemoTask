//
//  DetailViewController.swift
//  Memo
//
//  Created by nttr on 2017/07/20.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var selectedMemo: String!
    var selectedRow: Int!
    @IBOutlet var memoTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        memoTextView.text = selectedMemo
    }
    

    @IBAction func detailMemo(){
        let ud = UserDefaults.standard//udの設定
        if ud.array(forKey: KeyManager.saveKey) != nil{
        var saveMemoArray = ud.array(forKey: KeyManager.saveKey) as! [String]
            saveMemoArray.remove(at: selectedRow)
            ud.set(saveMemoArray, forKey: KeyManager.saveKey)
            ud.synchronize()
            self.navigationController?.popViewController(animated: true)
        }
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
