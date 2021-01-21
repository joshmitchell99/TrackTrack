//
//  ViewController.swift
//  TrackTrack1
//
//  Created by Josh Mitchell on 1/21/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.delegate = self
        myTableView.dataSource = self
        
        self.myTableView.reloadData()
    }
    
    @IBAction func newCompPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "New competition!", message: "Enter the name of the competition below:", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.autocapitalizationType = .words
        }
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            if textField?.text == "" {return}
            var competition = Competition()
            competition.name = textField!.text!
            V.competitions.append(competition)
            self.myTableView.reloadData()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return V.competitions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let competition = V.competitions[indexPath.row]
        
        cell.textLabel?.text = competition.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        V.competitionPassedIndex = indexPath.row
        self.performSegue(withIdentifier: "toJumpers", sender: self)
    }
    
    
}

