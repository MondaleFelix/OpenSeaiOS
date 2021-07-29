//
//  NFTListVC.swift
//  OpenSeaiOS
//
//  Created by Mondale on 7/28/21.
//

import UIKit

class NFTListVC: UIViewController {

    var tokens: [Token] = []
    let tableView = UITableView()
    var owner: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        configureTableView()
        getTokens()
    }
    

    private func configureTableView(){
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 100
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TokenCell.self, forCellReuseIdentifier: "TokenCell")
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }

    func getTokens(){
        NetworkManager.shared.getTokens(for: owner) { [weak self] (result) in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let tokenData):
                self.tokens.append(contentsOf: tokenData)

                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            case .failure(let error):
                print(error.rawValue)
                let alert = UIAlertController(title: "Error", message: error.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert,animated: true)
            }
        }
    }
    
}

extension NFTListVC: UITableViewDelegate {
    
}

extension NFTListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tokens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TokenCell.reuseID, for: indexPath) as! TokenCell
        let token = tokens[indexPath.row]
        cell.tokenTitleLabel.text = token.name

        
//        cell.downloadImage(from: token.image_url)
        
        
        return cell
    }
    
    
}
