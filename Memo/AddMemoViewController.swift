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
    @IBOutlet var memoTextFireld: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func saveMemo(){
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
        //niftyに投げる
        let object = NCMBObject(className: "Memo")//インデクスの指定
        object?.setObject(inputText, forKey: "text")//フィールドの指定
        object?.saveInBackground({ (error) in//動的保存
            if error != nil{
                print("error")
            }
            else{
                print("sucsess")
            }
        })
    }
    
    @IBAction func loadMemo(){
        let query = NCMBQuery(className: "Memo")
        query?.whereKey("text", equalTo: "わはは")//検索対象のフィールドと一致させるテキストを指定
        query?.findObjectsInBackground({ (result, error) in//取れるのは配列
            if error != nil{
                print("error")
            }
            else{
                //print(result)
                let memo = result as! [NCMBObject]
                print(memo)
                let text = memo.last?.object(forKey: "text") as! String
                self.memoTextView.text = text
            }
        })
    }
    
    @IBAction func updateMemo(){
        let query = NCMBQuery(className: "Memo")
        query?.whereKey("text", equalTo: "わはは")//指定のフィールドの値を検索条件にする
        query?.findObjectsInBackground({ (result, error) in//あらかじめ決めた検索条件でデータを配列で取得
        if error != nil{
            print(error)
        }
        else{
            let memo = result as! [NCMBObject]
            let textObject = memo.first//取得した配列の頭を保存
            textObject?.setObject("つも", forKey: "text")
            textObject?.saveInBackground({ (error) in
                if error != nil{
                    print(error)
                }
                else{
                    print("Update sucsess")
                }
            })
        }
    })
    }
    
    @IBAction func deleteMemo(){
        let query = NCMBQuery(className: "Memo")
        //query?.whereKey("text", equalTo: "てすと")
        query?.findObjectsInBackground({ (result, error) in
            if error != nil{
                print(error)
            }
            else{
             let memo = result as! [NCMBObject]
                let textObject = memo.first
                textObject?.deleteInBackground({ (error) in
                    if error != nil{
                        print(error)
                    }
                    else{
                        print("delete sucsess")
                    }
                })
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
