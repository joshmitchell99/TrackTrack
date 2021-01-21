//
//  JumperController.swift
//  TrackTrack1
//
//  Created by Josh Mitchell on 1/21/21.
//

import UIKit

class JumperController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var firstJumpField: UITextField!
    @IBOutlet weak var secondJumpField: UITextField!
    @IBOutlet weak var thirdJumpField: UITextField!
    
    @IBOutlet weak var myTableView: UITableView!
    
    @IBOutlet weak var competitionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.delegate = self
        myTableView.dataSource = self
        
        competitionLabel.text = V.competitions[V.competitionPassedIndex].name
        
        self.myTableView.reloadData()
    }
    
    @IBAction func addStudentPressed(_ sender: UIButton) {
        if nameTextField.text == "" || firstJumpField.text == "" || secondJumpField.text == "" || thirdJumpField.text == "" {
            return
        }
        
        var jumper = Jumper()
        jumper.name = nameTextField.text!
        jumper.jumps.append(Float(firstJumpField.text!)!)
        jumper.jumps.append(Float(secondJumpField.text!)!)
        jumper.jumps.append(Float(thirdJumpField.text!)!)
        
        V.competitions[V.competitionPassedIndex].jumpers.append(jumper)
        
        rankJumpers()
        myTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return V.competitions[V.competitionPassedIndex].jumpers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentCell", for: indexPath)
        let jumper = V.competitions[V.competitionPassedIndex].jumpers[indexPath.row]
        
        let jumps = jumper.jumps
        cell.textLabel?.text = jumper.name + ", " + String(jumps[0]) + ", " + String(jumps[1]) + ", " + String(jumps[2])
        return cell
    }
    
    @IBAction func backToCompetitionsPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func rankJumpers() {
        V.competitions[V.competitionPassedIndex].jumpers.sort {
            $0.jumps.min()! < $1.jumps.min()!
        }
    }
    
    
    

}
