//
//  JumperController.swift
//  TrackTrack1
//
//  Created by Josh Mitchell on 1/21/21.
//

import UIKit

class JumperController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var brain = Brain()
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var firstJumpField: UITextField!
    @IBOutlet weak var secondJumpField: UITextField!
    @IBOutlet weak var thirdJumpField: UITextField!
    
    @IBOutlet weak var myTableView: UITableView!
    
    @IBOutlet weak var titleLabel: UINavigationItem!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.delegate = self
        myTableView.dataSource = self
        
        titleLabel.title = V.competitions[V.compIndex].name
        
        self.myTableView.reloadData()
    }
    
    
    //MARK: - BUTTON FUNCTIONS
    @IBAction func newJumperPressed(_ sender: UIBarButtonItem) {
        if nameTextField.text == "" || firstJumpField.text == "" || secondJumpField.text == "" || thirdJumpField.text == "" {
            return
        }
        
        var jumper = Jumper(name: nameTextField.text!, jumps: [Float(firstJumpField.text!)!, Float(secondJumpField.text!)!, Float(thirdJumpField.text!)!])
        
        V.competitions[V.compIndex].jumpers.append(jumper)
        
        rankJumpers()
        brain.saveItems()
        myTableView.reloadData()
        
        nameTextField.text = ""
        firstJumpField.text = ""
        secondJumpField.text = ""
        thirdJumpField.text = ""
    }
    
    @IBAction func backToCompetitionsPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: - TABLEVIEW ESSENTIAL FUNCTIONS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return V.competitions[V.compIndex].jumpers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentCell", for: indexPath)
        let jumper = V.competitions[V.compIndex].jumpers[indexPath.row]
        
        if jumper.name == "test123123" {return cell}
        if indexPath.row < 10 {
            cell.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        }
        
        let jumps = jumper.jumps
        var cellDescription = jumper.name + ", " + String(jumps[0]) + ", " + String(jumps[1]) + ", " + String(jumps[2])
        if jumps.count == 6 {
            cellDescription.append(", " + String(jumps[3]) + ", " + String(jumps[4]) + ", " + String(jumps[5]))
        }
        cell.textLabel?.text = cellDescription
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let alert = UIAlertController(title: "Top Ten!", message: "Enter the additional three jumps here:", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Jump 4"
            textField.autocapitalizationType = .words
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Jump 5"
            textField.autocapitalizationType = .words
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Jump 6"
            textField.autocapitalizationType = .words
        }
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            
            if (alert?.textFields![0])!.text! == "" || (alert?.textFields![1])!.text! == "" || (alert?.textFields![2])!.text! == "" {
                return
            }
            
            V.competitions[V.compIndex].jumpers[indexPath.row].jumps.append(Float((alert?.textFields![0])!.text!)!)
            V.competitions[V.compIndex].jumpers[indexPath.row].jumps.append(Float((alert?.textFields![1])!.text!)!)
            V.competitions[V.compIndex].jumpers[indexPath.row].jumps.append(Float((alert?.textFields![2])!.text!)!)
            
            self.brain.saveItems()
            self.myTableView.reloadData()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    func rankJumpers() {
        V.competitions[V.compIndex].jumpers.sort {
            $0.jumps.max()! > $1.jumps.max()!
        }
    }
    
    
    
    
}
