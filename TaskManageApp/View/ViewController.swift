import UIKit


extension Date {
    var weekday: String {
        let calendar = Calendar(identifier: .gregorian)
        let component = calendar.component(.weekday, from: self)
        let weekday = component - 1
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en")
        return formatter.weekdaySymbols[weekday]
    }
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var titleArray = [String]()
    var descArray = [String]()
    var priorityArray = [String]()
    var genreArray = [String]()
    var dueArray = [String]()
//      var Array = [Post]()
    
    @IBOutlet var todayLabel: UILabel!
    @IBOutlet var monthLabel: UILabel!
    
    @IBOutlet var myTable: UITableView!
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        
            //　ナビゲーションバーの背景色
                self.navigationController?.navigationBar.barTintColor = .black
                // ナビゲーションバーのアイテムの色　（戻る　＜　とか　読み込みゲージとか）
                self.navigationController?.navigationBar.tintColor = .orange
                // ナビゲーションバーのテキストを変更する
                self.navigationController?.navigationBar.titleTextAttributes = [
                    // 文字の色
                    .foregroundColor: UIColor.orange
                ]
            
        
        
        myTable.dataSource = self
        myTable.delegate = self
        
        myTable.tableFooterView = UIView()
        
        self.myTable.estimatedRowHeight = 126
        self.myTable.rowHeight = UITableView.automaticDimension
        
        self.myTable.register(UINib(nibName: "MyCustomTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadTask()
        
        let now:Date = Date()
        let format = DateFormatter()
        let bFormat = DateFormatter()
        
        format.dateFormat = "dd"
        bFormat.dateFormat = "MM,"
        
        let sDay = format.string(from: now)
        let sMonth = bFormat.string(from: now)
        
        let weekday = Date().weekday
        
        todayLabel.text = sDay
        monthLabel.text = sMonth + weekday
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // return Array.count
        return priorityArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

      // let cell = myTable.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MyCustomTableViewCell
        
        let cell: MyCustomTableViewCell = self.myTable.dequeueReusableCell(withIdentifier: "Cell") as! MyCustomTableViewCell
        
        cell.titleLabel?.text = titleArray[indexPath.row]
        cell.priorityLabel?.text = priorityArray[indexPath.row]
        cell.descText?.text = descArray[indexPath.row]
        cell.genreText?.text = genreArray[indexPath.row]
        cell.dueLabel?.text = "■締切/Due： " + dueArray[indexPath.row]
        
        if cell.genreText?.text == "仕事/ワーク"{
            cell.genreText?.textColor = UIColor.init(red: 20/255, green: 49/255, blue: 9/255, alpha: 1.0)
        } else if cell.genreText?.text == "勉強/スタディ"{
            cell.genreText?.textColor = UIColor.init(red: 51/255, green: 101/255, blue: 138/255, alpha: 1.0)
        } else if cell.genreText?.text == "趣味/ホビー" {
            cell.genreText?.textColor = UIColor.init(red: 8/255, green: 72/255, blue: 135/255, alpha: 1.0)
        } else if cell.genreText?.text == "健康/ヘルス" {
            cell.genreText?.textColor = UIColor.init(red: 244/255, green: 93/255, blue: 94/255, alpha: 1.0)
        } else if cell.genreText?.text == "その他" {
            cell.genreText?.textColor = UIColor.gray
        } else {
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 126
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteButton: UITableViewRowAction = UITableViewRowAction(style: .normal, title: "Done") { (action, index) -> Void in
            self.priorityArray.remove(at: indexPath.row)
            self.descArray.remove(at: indexPath.row)
            self.genreArray.remove(at: indexPath.row)
            self.dueArray.remove(at: indexPath.row)
            self.titleArray.remove(at: indexPath.row)
            self.myTable.deleteRows(at: [indexPath], with: .fade)
            
            let ud = UserDefaults.standard
            
            ud.set(self.priorityArray, forKey: "priorityArray")
            ud.set(self.descArray, forKey: "descArray")
            ud.set(self.genreArray, forKey: "genreArray")
            ud.set(self.dueArray, forKey: "dueArray")
            ud.set(self.titleArray, forKey: "titleArray")

            ud.synchronize()
        }
        deleteButton.backgroundColor = UIColor.orange
        
        return [deleteButton]
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toDetail", sender: nil)
        myTable.deselectRow(at: indexPath, animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "toDetail" {
            
            let detailViewController = segue.destination as! DetailViewController
            let selectIndexPath = myTable.indexPathForSelectedRow!
            
            detailViewController.selectedDue = dueArray[selectIndexPath.row]
            detailViewController.selectedDesc = descArray[selectIndexPath.row]
            detailViewController.selectedGenre = genreArray[selectIndexPath.row]
            detailViewController.selectedTitle = titleArray[selectIndexPath.row]
            detailViewController.selectedPriority = priorityArray[selectIndexPath.row]
            
        }

    }
    
    func loadTask(){
        let ud = UserDefaults.standard
        
        if ud.array(forKey: "titleArray") != nil {
           titleArray = ud.array(forKey: "titleArray") as! [String]
           myTable.reloadData()
        }

        if ud.array(forKey: "descArray") != nil {
           descArray = ud.array(forKey: "descArray") as! [String]
            myTable.reloadData()
        }

        if ud.array(forKey: "priorityArray") != nil {
           priorityArray = ud.array(forKey: "priorityArray") as! [String]
           myTable.reloadData()
        }
        
        if ud.array(forKey: "genreArray") != nil {
            genreArray = ud.array(forKey: "genreArray") as! [String]
            print(genreArray)
            myTable.reloadData()
        }
        
        if ud.array(forKey: "dueArray") != nil {
            dueArray = ud.array(forKey: "dueArray") as! [String]
            myTable.reloadData()
        }
       
    }
    


}

