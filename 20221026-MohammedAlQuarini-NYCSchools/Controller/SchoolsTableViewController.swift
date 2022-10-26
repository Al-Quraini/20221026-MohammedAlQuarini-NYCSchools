//
//  ViewController.swift
//  20221026-MohammedAlQuarini-NYCSchools
//
//  Created by Mohammed Al-Quraini on 10/26/22.
//

import UIKit

class SchoolsTableViewController: UITableViewController {
    
    var networkManager : NetworkManagerProtocol = NetworkManager()
    var schools : [NYCHighSchoolModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
        getData()
    }
    
    private func setup(){
        // setup table view
        tableView.register(NYCSchoolTableViewCell.self, forCellReuseIdentifier: NYCSchoolTableViewCell.id)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 200
    }
    
    func getData(){
        // get the data from the server
        networkManager.performRequest([NYCHighSchoolModel].self, from: NetworkURLs.baseURL) { [weak self] result in
            switch result {
                
                // in success case, assign schools data to schools property
                // reload table view
            case .success(let response):
                self?.schools = response
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                
                // failure case
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

//MARK: - TableViewDelegate
extension SchoolsTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - TableViewDataSource
extension SchoolsTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // rows limit is 20
        return schools.count >= 20 ? 20 : schools.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // dequeue the reusable cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NYCSchoolTableViewCell.id, for: indexPath)
                as? NYCSchoolTableViewCell else {
            return UITableViewCell()
        }
        // if the row index is odd, the background color is green, otherwise white
        if indexPath.row % 2 == 1 {
            cell.backgroundColor = .systemGreen.withAlphaComponent(0.5)
        } else {
            cell.backgroundColor = .clear
        }
        // configure cell views, passing the model at the current index
        cell.configCell(model: schools[indexPath.row])
        
        return cell
    }
    
}
