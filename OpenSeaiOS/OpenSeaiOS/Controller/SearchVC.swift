//
//  SearchVC.swift
//  OpenSeaiOS
//
//  Created by Mondale on 7/27/21.
//

import UIKit

class SearchVC: UIViewController {

    
    let logoImageView = UIImageView()
    let walletAddressTF = OSTextField()
    let getNFTButton = OSButton(backgroundColor: .systemBlue, title: "Get NFTs")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureLogoImageView()
        configureTextField()
        configureNFTButton()
        
        createDimissKeyboardTapGesture()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    func createDimissKeyboardTapGesture(){
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    
    @objc func pushNFTListVC(){
        let userNFTListVC = NFTListVC()
        userNFTListVC.title = walletAddressTF.text
        navigationController?.pushViewController(userNFTListVC, animated: true)
    }
    
    
    func configureLogoImageView(){
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        logoImageView.image = UIImage(named: "opensea")

        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configureTextField(){
        view.addSubview(walletAddressTF)
        walletAddressTF.delegate = self
        NSLayoutConstraint.activate([
            walletAddressTF.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            walletAddressTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            walletAddressTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            walletAddressTF.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    func configureNFTButton(){
        view.addSubview(getNFTButton)
        
        getNFTButton.addTarget(self, action: #selector(pushNFTListVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            getNFTButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            getNFTButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            getNFTButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            getNFTButton.heightAnchor.constraint(equalToConstant: 50)
        
        ])
    }

}

extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushNFTListVC()
        return true
    }
    
}
