import UIKit

class DetailViewController: UIViewController {
    
    var selectedTitle: String!
    var selectedPriority: String!
    var selectedGenre: String!
    var selectedDesc: String!
    var selectedDue: String!

    @IBOutlet var taskTitle: UILabel!
    @IBOutlet var priority: UILabel!
    @IBOutlet var genre: UILabel!
    @IBOutlet var due: UILabel!
    @IBOutlet var desc: UITextView!
    
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

        taskTitle.text = selectedTitle
        priority.text = "Priority: " + selectedPriority
        genre.text = "Genre: " + selectedGenre
        desc.text = selectedDesc
        due.text = selectedDue
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toEdit"{
            
            let edit = segue.destination as! EditViewController
            
            let editTitle = selectedTitle
            let editPriority = selectedPriority
            let editGenre = selectedGenre
            let editDesc = selectedDesc
            let editdue = selectedDue
            
            edit.one = editTitle
            edit.two = editGenre
            edit.three = editPriority
            edit.four = editDesc
            edit.five = editdue
            
            print(editTitle)
        }

    }
    
    @IBAction func edit(){
        
        self.performSegue(withIdentifier: "toEdit", sender: nil)
    }
    

}
