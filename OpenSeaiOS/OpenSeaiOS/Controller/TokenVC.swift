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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureTokenImageView()
        downloadImage(from: tokenImageUrl)
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
            tokenImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            tokenImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tokenImageView.heightAnchor.constraint(equalToConstant: 200),
            tokenImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }


}
