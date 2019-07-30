
import UIKit

class EditViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource,UITextFieldDelegate,UITextViewDelegate {
    
    var one: String!
    var two: String!
    var three: String!
    var four: String!
    var five: String!

    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var contentTextField: UITextView!
    @IBOutlet var priorityTextField: UITextField!
    @IBOutlet var genreTextField: UITextField!
    @IBOutlet var dueTextField: UITextField!
    
    var priotityPickerView: UIPickerView = UIPickerView()
    var genrePickerView: UIPickerView = UIPickerView()
    let priorities = ["★1", "★2", "★3"]
    let genres = ["仕事/ワーク", "勉強/スタディ", "趣味/ホビー", "健康/ヘルス", "その他"]
    
    
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
        
        print(one)
        
        titleTextField.text = one
        genreTextField.text = two
        priorityTextField.text = three
        dueTextField.text = five
        contentTextField.text = four
        
        //pickerView1
        priotityPickerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height:priotityPickerView.bounds.size.height)
        priotityPickerView.tag = 1             // <<<<<<<<<<　追加
        priotityPickerView.delegate   = self
        priotityPickerView.dataSource = self
        
        titleTextField.delegate = self
        contentTextField.delegate = self
        dueTextField.delegate = self
        
        let vi1 = UIView(frame: priotityPickerView.bounds)
        vi1.backgroundColor = UIColor.white
        vi1.addSubview(priotityPickerView)
        
        priorityTextField.inputView = vi1
        
        let toolBar1 = UIToolbar()
        toolBar1.barStyle = UIBarStyle.default
        toolBar1.isTranslucent = true
        toolBar1.tintColor = UIColor.black
        let doneButton1   = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(SecondViewController.donePressed))
        let spaceButton1  = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolBar1.setItems([spaceButton1, doneButton1], animated: false)
        toolBar1.isUserInteractionEnabled = true
        toolBar1.sizeToFit()
        priorityTextField.inputAccessoryView = toolBar1
        
        //pickerView2
        genrePickerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: genrePickerView.bounds.size.height)
        genrePickerView.tag = 2             // <<<<<<<<<<　追加
        genrePickerView.delegate   = self
        genrePickerView.dataSource = self
        
        let vi2 = UIView(frame: genrePickerView.bounds)
        vi2.backgroundColor = UIColor.white
        vi2.addSubview(genrePickerView)
        
        genreTextField.inputView = vi2
        
        let toolBar2 = UIToolbar()
        toolBar2.barStyle = UIBarStyle.default
        toolBar2.isTranslucent = true
        toolBar2.tintColor = UIColor.black
        let doneButton2   = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(SecondViewController.donePressed))
        let spaceButton2  = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolBar2.setItems([spaceButton2, doneButton2], animated: false)
        toolBar2.isUserInteractionEnabled = true
        toolBar2.sizeToFit()
        genreTextField.inputAccessoryView = toolBar2
    }
    
    @objc func donePressed() {
        view.endEditing(true)
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView.tag ==   1 {
            return priorities.count
        } else {
            return genres.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView.tag ==   1 {
            return priorities[row]
        } else {
            return genres[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag ==   1 {
            return priorityTextField.text = priorities[row]
        } else {
            return genreTextField.text = genres[row]
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func save(){
        
        // let content = textField.text
        
        let title = titleTextField.text
        let description = contentTextField.text
        let priority = priorityTextField.text
        let genre = genreTextField.text
        let due = dueTextField.text
        
        let ud = UserDefaults.standard
        
        if title != nil {
            
            if ud.array(forKey: "titleArray") != nil {
                var saveMemoArray = ud.array(forKey: "titleArray") as! [String]
                saveMemoArray.append(title!)
                print(saveMemoArray)
                ud.set(saveMemoArray, forKey: "titleArray")
                ud.synchronize()
                self.navigationController?.popViewController(animated: true)
                
            } else {
                var newMemoArray = [String]()
                newMemoArray.append(title!)
                print(newMemoArray)
                ud.set(newMemoArray, forKey: "titleArray")
                ud.synchronize()
                self.navigationController?.popViewController(animated: true)
            }
            
        }
        
        if description != nil {
            
            if ud.array(forKey: "descArray") != nil {
                var savetwoMemoArray = ud.array(forKey: "descArray") as! [String]
                savetwoMemoArray.append(description!)
                print(savetwoMemoArray)
                ud.set(savetwoMemoArray, forKey: "descArray")
                ud.synchronize()
                self.navigationController?.popViewController(animated: true)
                
            } else {
                var newtwoMemoArray = [String]()
                newtwoMemoArray.append(description!)
                print(newtwoMemoArray)
                ud.set(newtwoMemoArray, forKey: "descArray")
                ud.synchronize()
                self.navigationController?.popViewController(animated: true)
            }
            
        }
        
        if priority != nil {
            
            if ud.array(forKey: "priorityArray") != nil {
                var savethreeMemoArray = ud.array(forKey: "priorityArray") as! [String]
                savethreeMemoArray.append(priority!)
                print(savethreeMemoArray)
                ud.set(savethreeMemoArray, forKey: "priorityArray")
                ud.synchronize()
                self.navigationController?.popViewController(animated: true)
                
            } else {
                var newthreeMemoArray = [String]()
                newthreeMemoArray.append(priority!)
                print(newthreeMemoArray)
                ud.set(newthreeMemoArray, forKey: "priorityArray")
                ud.synchronize()
                self.navigationController?.popViewController(animated: true)
            }
            
            if genre != nil {
                
                if ud.array(forKey: "genreArray") != nil {
                    var savefourMemoArray = ud.array(forKey: "genreArray") as! [String]
                    savefourMemoArray.append(genre!)
                    print(savefourMemoArray)
                    ud.set(savefourMemoArray, forKey: "genreArray")
                    ud.synchronize()
                    self.navigationController?.popViewController(animated: true)
                    
                } else {
                    var newfourMemoArray = [String]()
                    newfourMemoArray.append(genre!)
                    print(newfourMemoArray)
                    ud.set(newfourMemoArray, forKey: "genreArray")
                    ud.synchronize()
                    self.navigationController?.popViewController(animated: true)
                }
            }
            
            if due != nil {
                
                if ud.array(forKey: "dueArray") != nil {
                    var savefiveMemoArray = ud.array(forKey: "dueArray") as! [String]
                    savefiveMemoArray.append(due!)
                    print(savefiveMemoArray)
                    ud.set(savefiveMemoArray, forKey: "dueArray")
                    ud.synchronize()
                    self.navigationController?.popViewController(animated: true)
                    
                } else {
                    var newfiveMemoArray = [String]()
                    newfiveMemoArray.append(due!)
                    print(newfiveMemoArray)
                    ud.set(newfiveMemoArray, forKey: "dueArray")
                    ud.synchronize()
                    self.navigationController?.popViewController(animated: true)
                }
            }
            
        } else {
            self.navigationController?.popViewController(animated: true)
        }
        
        

    }
}
