//
//  ApplicationViewController.swift
//  iTunesAppsLibrary
//
//  Created by Arturo Murillo on 2/27/17.
//  Copyright © 2017 Arturo Murillo. All rights reserved.
//

import UIKit

class ApplicationViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet fileprivate weak var imageView: UIImageView!
    @IBOutlet fileprivate weak var summaryLabel: UILabel!
    @IBOutlet fileprivate weak var linkButton: UIButton!
    
    //MARK: - Properties
    fileprivate let viewModel: ApplicationViewModel
    
    init(viewModel: ApplicationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: ApplicationViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    //MARK: - Setup
    fileprivate func setup() {
        title = viewModel.applicationTitle()
        if let imageURLString = viewModel.applicationImage(), let url = URL(string: imageURLString) {
            imageView.setImage(withURL: url, placeholderImage: nil)
        }
        summaryLabel.text = viewModel.applicationSummary()
        linkButton.setTitle(viewModel.applicationLink(), for: .normal)
        
        let button = UIBarButtonItem(title: LocalizableString.close.localizedString, style: .plain, target: self, action: #selector(closeButtonTapped))
        navigationItem.rightBarButtonItem = button
    }
    
    //MARK: - IBActions
    @objc fileprivate func closeButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func linkButtonTapped(_ sender: Any) {
        if let imageURLString = viewModel.applicationLink(), let url = URL(string: imageURLString) {
            UIApplication.shared.openURL(url)
        }
    }
}

