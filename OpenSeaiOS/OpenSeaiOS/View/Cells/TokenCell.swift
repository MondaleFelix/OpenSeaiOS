//
//  TokenCell.swift
//  OpenSeaiOS
//
//  Created by Mondale on 7/29/21.
//

import UIKit

class TokenCell: UITableViewCell {

    static let reuseID = "TokenCell"
    
    var tokenTitleLabel = UILabel()
    var tokenImageView: UIImageView?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style:style, reuseIdentifier: reuseIdentifier)
        configureTitleLabel()
        configureImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    
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
                self.tokenImageView?.image = image
            }

        }
        task.resume()
    }

    
    
    private func configureTitleLabel(){
        addSubview(tokenTitleLabel)
        tokenTitleLabel.textColor = .black
        tokenTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        tokenTitleLabel.font = UIFont.preferredFont(forTextStyle: .body)

        tokenTitleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        tokenTitleLabel.numberOfLines = 0
        tokenTitleLabel.adjustsFontSizeToFitWidth = true
        
        NSLayoutConstraint.activate([
        
            tokenTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            tokenTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            tokenTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -150),
            tokenTitleLabel.heightAnchor.constraint(equalToConstant: 80),
            
        ])
    }
    
    
    private func configureImageView(){
        tokenImageView = UIImageView()
        guard let tokenImageView = tokenImageView else { return }
        
        addSubview(tokenImageView)
        tokenImageView.translatesAutoresizingMaskIntoConstraints = false
        tokenImageView.contentMode = .scaleAspectFill
        tokenImageView.layer.cornerRadius = 10
        tokenImageView.clipsToBounds = true
        NSLayoutConstraint.activate([
            tokenImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            tokenImageView.leadingAnchor.constraint(equalTo: tokenTitleLabel.trailingAnchor),
            tokenImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            tokenImageView.heightAnchor.constraint(equalToConstant: 80),

        ])
    }
    
    
}
