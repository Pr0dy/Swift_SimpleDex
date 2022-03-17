//
//  PokemonListViewController.swift
//  Leandro_PokedexApp
//
//  Created by leandro.banha on 17/03/2022.
//

import UIKit

class PokemonListViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    let rows = ["001: X", "002: Y", "c", "d", "e", "f" , "g"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
}
    
    extension PokemonListViewController: UITableViewDelegate, UITableViewDataSource
{
        func numberOfSections(in tableView: UITableView) -> Int {
            return rows.count
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        
         func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
            
             cell.textLabel?.text = rows[indexPath.section]
             
            
            return cell
        }
    }


