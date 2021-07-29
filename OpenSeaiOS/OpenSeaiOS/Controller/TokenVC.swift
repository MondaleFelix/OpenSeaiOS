//
//  TokenVC.swift
//  OpenSeaiOS
//
//  Created by Mondale on 7/29/21.
//

import UIKit

class TokenVC: UIViewController {

    let tokenImageView = UIImageView()
    var tokenImageUrl: String = ""
    var tokenAddressLabel = UILabel()
    var tokenContractLabel = UILabel()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureTokenImageView()
        downloadImage(from: tokenImageUrl)
        configureTokenAddressLabel()
        configureTokenContractLabel()
        
    }
    
    func downloadImage(from urlString: String?){

        guard let urlString = urlString else { return }
        
        guard let url = URL(string: urlString) else { return }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in

            guard let self = self else { return }


            if let _ = error { return }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            
            guard let data = data else { return }

            guard let image = UIImage(data: data) else { return }

            // Adds the image to cache
            DispatchQueue.main.async {
                self.tokenImageView.image = image
            }

        }
        task.resume()
    }
    
    
    func configureTokenImageView(){
        view.addSubview(tokenImageView)
        tokenImageView.translatesAutoresizingMaskIntoConstraints = false
        
        tokenImageView.image = UIImage(named: "opensea")

        NSLayoutConstraint.activate([
            tokenImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            tokenImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tokenImageView.heightAnchor.constraint(equalToConstant: 200),
            tokenImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configureTokenAddressLabel(){
        view.addSubview(tokenAddressLabel)
        tokenAddressLabel.translatesAutoresizingMaskIntoConstraints = false
        tokenAddressLabel.adjustsFontSizeToFitWidth = true
        
        NSLayoutConstraint.activate([
        
            tokenAddressLabel.topAnchor.constraint(equalTo: tokenImageView.bottomAnchor, constant: 20),
            tokenAddressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tokenAddressLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tokenAddressLabel.heightAnchor.constraint(equalToConstant: 50)
        
        ])
    }
    
    func configureTokenContractLabel(){
        view.addSubview(tokenContractLabel)
        tokenContractLabel.translatesAutoresizingMaskIntoConstraints = false
        tokenContractLabel.adjustsFontSizeToFitWidth = true
        NSLayoutConstraint.activate([
        
            tokenContractLabel.topAnchor.constraint(equalTo: tokenAddressLabel.bottomAnchor, constant: 20),
            tokenContractLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tokenContractLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tokenContractLabel.heightAnchor.constraint(equalToConstant: 50)
        
        ])
    }




}
