//
//  ViewController.swift
//  Memo
//
//  Created by nttr on 2017/07/20.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit
import MCSwipeTableViewCell

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var memoArray = [String]()
    @IBOutlet var memoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        memoTableView.dataSource = self
        memoTableView.delegate = self
        //loadMemo()
    }

    override func viewWillAppear(_ animated: Bool) {
        loadMemo()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemoCell")!
        cell.textLabel?.text = memoArray[indexPath.row]
        return cell
    }
    //tableviewを押した後に遷移する
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetail", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)//diselectの設定
    }
    //セルの数を管理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            let detailViewController = segue.destination as! DetailViewController
            let selectedIndexPath = memoTableView.indexPathForSelectedRow!
            detailViewController.selectedMemo = memoArray[selectedIndexPath.row]
            detailViewController.selectedRow = selectedIndexPath.row
        }
    }
    //セルの削除
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            memoArray.remove(at: indexPath.row)//選択しているセルの削除
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        self.navigationController?.popViewController(animated: true)
        let ud = UserDefaults.standard//udの設定
        if ud.array(forKey: KeyManager.saveKey) != nil{
            ud.set(memoArray, forKey: KeyManager.saveKey)
            ud.synchronize()
        }
    }
    
    func loadMemo(){
        let ud = UserDefaults.standard
        if ud.array(forKey: KeyManager.saveKey) != nil {
            memoArray = ud.array(forKey: KeyManager.saveKey) as! [String]
            memoTableView.reloadData()
        }
    }
    
}

